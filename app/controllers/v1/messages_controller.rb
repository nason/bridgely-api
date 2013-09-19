# TODO: Setup serializer

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
      @v1_message.update :message_sid => send_sms_message
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
    @account = @twilio_client.account
    @account_number = @account.incoming_phone_numbers.list.first.phone_number
    @recipient = V1::Employee.find(@v1_message.employee_id)
    @company = V1::Admin::Company.find(@v1_message.company_id)
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
