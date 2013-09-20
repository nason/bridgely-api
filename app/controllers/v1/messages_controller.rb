# TODO: Setup serializer
# TODO: Dont take company_id as a param unless admin, determine it from the logged in user

# TODO: Create employee_message JOIN table with employee, message, and question foreign keys
# TODO: Utilize the employee_message table in the Message, Question and Twilio controllers
# TODO: employee_id param should be employee_ids => an array of employees to be
#        sent the message, or the string 'all' to send to whole company
# TODO: Update send_sms_message to send a message for each id in the employee_ids array
# TODO: Dont take question_id param, question controller will create question record and message record
# TODO: Determine the relationship path to tag an incoming message as a response to a question
# TODO: Consider concentrating Twillio integration into employee_message model

class V1::MessagesController < ApplicationController
  before_filter :require_token
  before_filter :create_twilio_client, only: [:create]

  # GET /v1/messages
  # Return all messages
  def index
    @v1_messages = V1::Message.all

    render json: @v1_messages
  end

  # GET /v1/messages/1
  # Find and return a single message by id
  def show
    @v1_message = V1::Message.find(params[:id])

    render json: @v1_message
  end

  # POST /v1/messages
  # Send an OUTGOING SMS message
  def create
    @v1_message = V1::Message.new(message_params)

    if @v1_message.save
      @v1_message.update :message_sid => send_sms_message, :status => 'sent'
      render json: @v1_message, status: :created, location: @v1_message
    else
      render json: @v1_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/messages/1
  # Update an existing message record
  def update
    @v1_message = V1::Message.find(params[:id])

    if @v1_message.update(message_params)
      render json: @v1_message, status: :ok
    else
      render json: @v1_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/messages/1
  # Delete a message record
  def destroy
    @v1_message = V1::Message.find(params[:id])
    @v1_message.destroy

    head :no_content
  end

  private
  def message_params
    params.require(:message).permit(:company_id, :employee_id, :question_id, :body, :data, :direction, :status)
  end

  def send_sms_message
    @company = V1::Admin::Company.find(@v1_message.company_id)
    @account = @twilio_client.accounts.get(@company.account_sid)
    @account_number = @company.settings[:account_phone_number]
    @recipient = V1::Employee.find(@v1_message.employee_id)
    @body = @v1_message.body

    @message = @account.messages.create({
      :from => @account_number,
      :to => @recipient.phone,
      :body => @body
      # Above is for an incoming message
      # Interpolation can create cool replies
      # :body => "Responding from #{@account_number} to #{@recipient.name}, employee of #{@company.name}!"
    })

    return @message.sid
  end

end
