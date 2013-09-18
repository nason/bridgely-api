class V1::MessagesController < ApplicationController
  before_filter :require_token

  # TODO: Strip out unnecessary params on update
  # TODO: Setup serializer

  # GET /v1/messages
  # GET /v1/messages.json
  def index
    @v1_messages = V1::Message.all

    render json: @v1_messages
  end

  # GET /v1/messages/1
  # GET /v1/messages/1.json
  def show
    @v1_message = V1::Message.find(params[:id])

    render json: @v1_message
  end

  # POST /v1/messages
  # POST /v1/messages.json
  def create
    @v1_message = V1::Message.new(message_params)

    if @v1_message.save
      render json: @v1_message, status: :created, location: @v1_message
    else
      render json: @v1_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/messages/1
  # PATCH/PUT /v1/messages/1.json
  def update
    @v1_message = V1::Message.find(params[:id])

    if @v1_message.update(message_params)
      render json: @v1_message, status: :ok
    else
      render json: @v1_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/messages/1
  # DELETE /v1/messages/1.json
  def destroy
    @v1_message = V1::Message.find(params[:id])
    @v1_message.destroy

    head :no_content
  end

  private
  def message_params
    params.require(:message).permit(:company_id, :employee_id, :question_id, :body, :data, :direction, :status)
  end
end
