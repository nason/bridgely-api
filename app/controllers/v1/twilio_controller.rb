# TODO: Unclear if AccountSID is the main account or subaccount, if it is the main account can do find by :to phone number
# TODO: Create subaccount for each company, store it in company table
# TODO: Add MessageSid column to message table
# TODO: If incoming message corresponds to a message record with a question id, store response as a tag

class V1::TwilioController < ApplicationController

  # POST /v1/twilio/inbound
  # Request:  Twilio POSTS incoming text message data to this path
  # Response: Twilio retrieves and executes TwiML returned
  def create

    # Find the company associated with the AccountSid
    @company = V1::Admin::Company.find_by_account_sid( twilio_params[:AccountSid] )

    if @company

      # Find or the employee associated with the company_id and phone number
      @employee = V1::Employee.find_by_phone( twilio_params[:phone] ).where( :company_id => @company.id )

      if @employee

        # If the employee exists, record the message
        @message = V1::Message.new({
          :employee_id => @employee.id,
          :company_id  => @company.id,
          :message_sid => twilio_params[:MessageSid],
          :body        => twilio_params[:Body],
          :status      => twilio_params[:SmsStatus]
          :direction   => 'inbound'
        })
      else

        # Create an employee record, and a message record
        @employee = V1::Employee.new({
          :company_id  => @company.id,
          :name        => twilio_params[:Body],
          :phone       => twilio_params[:From],
        })

        @message = V1::Message.new({
          :employee_id => @employee.id,
          :company_id  => @company.id,
          :message_sid => twilio_params[:MessageSid],
          :body        => twilio_params[:Body],
          :status      => twilio_params[:SmsStatus]
          :direction   => 'inbound'
        })
      end

    end

    # And then send a response? TwilML can go here, or we can create a new outbound message...
    render :json=> {:success=>true}, status: :ok
  end

  # POST /v1/twilio/status
  # Twilio makes this POST request when a API request to send an outgoing message has either succeeded or failed.

  def update

    # Find the message by SID
    @message = V1::Message.find_by_message_sid( twilio_params[:MessageSid] )

    # Update the status
    @message.update_attribute( :status, twilio_params[:SmsStatus] )

    render status: :ok
  end

  private
  def twilio_params
    params.permit( :AccountSid, :MessageSid, :Body, :To, :SmsStatus, :From )
  end

end
