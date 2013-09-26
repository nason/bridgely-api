# TODO: Make sure Twilio requests pass validation for subaccounts => Need to store subaccount auth key on company record => @subaccount.auth_token

# TODO: Prevent followups after response and before another question from overwriting responses => store them in an :unprocessable array inside data?
#       Right now, labels keep getting added to labels, and values get overridden in tags

class V1::TwilioController < ApplicationController
  # before_filter :validate_twilio_header

  # POST /v1/twilio/inbound
  # Request:  Twilio POSTS incoming text message data to this path
  # Response: Twilio retrieves and (if new employee returns TwiML autoresponder)
  def create
    @company = V1::Admin::Company.find_by account_sid: twilio_params[:AccountSid]

    if @company

      @record = V1::Activity.new(
        :message_sid => twilio_params[:MessageSid],
        :sms_status  => twilio_params[:SmsStatus]
      )

      @record.create_message(
        :company_id => @company.id,
        :body       => twilio_params[:Body],
        :direction  => 'inbound'
      )

      # @employee = V1::Employee.find_by "company_id = ? AND phone = ?", @company.id, twilio_params[:From]
      @employee = V1::Employee.where(company_id: @company.id).find_by(phone: twilio_params[:From])

      if @employee
        @record.employee_id = @employee.id
        process_question_response
      else
        @employee = @record.build_employee(
          :phone      => twilio_params[:From],
          :name       => twilio_params[:Body],
          :company_id => @company.id
        )
      end

      if @employee.persisted?
        @record.save
        @record.message.save
        @employee.save #save changes to the employee data attribute
        render :json=> {:success => true}, status: :ok
      else
        @record.save
        @employee.save
        render :xml=> twiml_response, status: :ok
      end
    end

  end

  # POST /v1/twilio/status
  # Twilio makes this POST request when a API request to send an outgoing message has either succeeded or failed.
  def update

    # Find the message by SID
    @message = V1::Activity.find_by message_sid: twilio_params[:MessageSid]

    # Update the status
    @message.update( sms_status: twilio_params[:SmsStatus] )

    render status: :ok
  end

  private
  def twilio_params
    params.permit( :AccountSid, :MessageSid, :Body, :To, :SmsStatus, :From )
  end

  def process_question_response
    @last_employee_question_activity = V1::Activity.where( "employee_id = ? AND question_id IS NOT NULL", @employee.id ).last
    if @last_employee_question_activity.nil?
      # TODO: tag the message as unrelatable to a question?
    else
      @last_employee_question = @last_employee_question_activity.question
      if @last_employee_question.response_tag?

        # first make sure tags hash exists
        @employee[:data][:tags] = {} unless @employee[:data][:tags]

        # then save message response as a tag
        @employee[:data][:tags][ @last_employee_question.response_tag ] = @record.message.body
      else

        # first make sure labels exists, otherwise make it an empty array
        @employee[:data][:labels] = [] unless @employee[:data][:labels]

        # then save it into the labels array
        @employee[:data][:labels].push ( @record.message.body )
      end

      # Make sure the record and message get the question_id
      @record.question_id = @last_employee_question.id
      @record.message.question_id = @last_employee_question.id
    end
  end

  def twiml_response

    #Create the approriate activity and message records, MessageSID will be unknown but that's ok.

    # [company] => #{@company.name}
    # [name] => #{ @employee.name.split.first }

    # autoresponder = @company[:settings][:autoresponder] # Needs interpolation
    autoresponder = interpolate_autoresponder
    responder_link = @company[:settings][:responder_link_root] # + /some-hash-related-to-either-the-employees-phone-number-or-company_id+employee_id

    response = V1::Activity.new(
      :employee_id => @employee.id,
      :message_sid => 'autoresponder',
      :sms_status => 'sent'
    )
    message = response.create_message(
      :company_id => @company.id,
      :body => autoresponder,
      :direction => 'outbound'
    )
    response.save

    # Return autoresponder in TwiML
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message do |message|
        message.Body autoresponder
      end
    end
    twiml.text
  end

  def interpolate_autoresponder
    @company[:settings][:autoresponder]
      .gsub( /\[name\]/, @employee.name.split.first )
      .gsub( /\[company\]/, @company.name )
  end

  # def validate_twilio_header
  #   # First, instantiate a RequestValidator object with  SUBaccount's AuthToken.
  #   validator = Twilio::Util::RequestValidator.new( @subaccount.TWILIO_AUTH_TOKEN )

  #   # Then gather the data required to validate the request
  #   uri = request.original_url

  #   # Collect all parameters passed from Twilio.
  #   params = env['rack.request.form_hash']

  #   # Grab the signature from the HTTP header.
  #   signature = env['HTTP_X_TWILIO_SIGNATURE']

  #   # Finally, call the validator's #validate method.
  #   head(422) unless validator.validate(uri, params, signature) #true if the request is from Twilio
  # end
end
