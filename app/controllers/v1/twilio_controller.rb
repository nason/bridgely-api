# TODO: If incoming message corresponds to a message record with a question id, store response as a tag
# TODO: Make sure Twilio requests pass validation for main and subaccounts

class V1::TwilioController < ApplicationController
  # before_filter :validate_twilio_header

  # POST /v1/twilio/inbound
  # Request:  Twilio POSTS incoming text message data to this path
  # Response: Twilio retrieves and executes TwiML returned
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

      @employee = V1::Employee.find_by "company_id = ? AND phone = ?", @company.id, twilio_params[:From]

      if @employee
        @record.employee_id = @employee.id
      else
        @employee = @record.build_employee(
          :phone      => twilio_params[:From],
          :name       => twilio_params[:Body],
          :company_id => @company.id
        )
      end

      if @employee.persisted?
        render :json=> {:success => true}, status: :ok
      else
        render :xml=> twiml_response, status: :ok
      end
      @record.save

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

  def twiml_response

    # TODO: Create the approriate activity and message records, MessageSID will be unknown but thats ok.
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message do |message|
        message.Body "Thanks for joining the #{@company.name} mobile directory, #{ @employee.name.split.first }!"
      end
    end
    twiml.text
  end

  # def validate_twilio_header
  #   # First, instantiate a RequestValidator object with your account's AuthToken.
  #   validator = Twilio::Util::RequestValidator.new( TWILIO_AUTH_TOKEN )

  #   # Then gather the data required to validate the request
  #   uri = request.original_url

  #   # Collect all parameters passed from Twilio.
  #   params = env['rack.request.form_hash']

  #   # Grab the signature from the HTTP header.
  #   signature = env['HTTP_X_TWILIO_SIGNATURE']

  #   puts uri
  #   puts params
  #   puts signature

  #   # Finally, call the validator's #validate method.
  #   head(422) unless validator.validate(uri, params, signature) #=> true if the request is from Twilio
  # end

end
