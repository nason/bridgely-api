# TODO: If incoming message corresponds to a message record with a question id, store response as a tag
# TODO: Make sure Twilio requests pass validation for main and subaccounts

class V1::TwilioController < ApplicationController
  # before_filter :validate_twilio_header

  # POST /v1/twilio/inbound
  # Request:  Twilio POSTS incoming text message data to this path
  # Response: Twilio retrieves and executes TwiML returned
  def create

    # Find the company associated with the AccountSid
    @company = V1::Admin::Company.find_by account_sid: twilio_params[:AccountSid]

    if @company

      # Find the employee associated with the company_id and phone number
      @employee = V1::Employee.find_or_initialize_by phone: twilio_params[:From], company_id: @company.id

      # Create the employee if record does not exist
      @employee = V1::Employee.update({
        :name        => twilio_params[:Body],
      }) unless @employee.persisted?

      # TODO: Else add the response as a tag or a label, find last question sent to employee and associate it

      # Create the message
      @message = @employee.messages.create({
        :company_id  => @company.id,
        :body        => twilio_params[:Body],
        :direction   => 'inbound'
      })

      # Create the activity
      @activity = @employee.activity.create({
        :employee_id   => @employee.id,
        :message_id    => @message.id,
        # :question_id   => @question.id,
        :message_sid   => twilio_params[:MessageSid],
        :sms_status    => twilio_params[:SmsStatus]
        })

    end

    # And then send a response? TwilML can go here, or we can create a new outbound message...
    render :json=> {:success=>true}, status: :ok
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
