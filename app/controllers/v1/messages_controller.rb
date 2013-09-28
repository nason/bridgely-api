# TODO: Setup serializer
# TODO: Dont take company_id as a param unless admin, determine it from the logged in user

# TODO: Consider concentrating Twillio integration methods into employee_message model

class V1::MessagesController < ApplicationController
  before_filter :require_token
  before_filter :create_twilio_client, only: [:create]

  # GET /v1/messages
  # Return all messages
  def index

    if @current_user.admin?
      @v1_messages = V1::Message.all
    else
      @v1_messages = V1::Message.all.where(company_id: @current_user.company.id)
    end

    render json: @v1_messages
  end

  # GET /v1/employees/1/messages
  # Returns all messages that are to or from a particular employee
  def employee_index
    @v1_employee = V1::Employee.find(params[:employee_id])

    if @current_user.admin? or @current_user.company_id === @v1_employee.company.id
      @v1_activity = V1::Activity.find_by employee_id: @v1_employee.id
      render json: @v1_activity
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end
  end

  # GET /v1/companies/1/messages
  # Return all messages for a specific company, useful for admin switching between companies
  def company_index

    if @current_user.admin? or @current_user.company.id == params[:company_id].to_i
      @v1_messages = V1::Message.all.where(company_id: params[:company_id])
      render json: @v1_messages
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end

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
    @v1_message = V1::Message.new( message_params.except(:employee_ids) )

    if message_params[:employee_ids] === 'all'

      # If :employee_ids param is 'all', send to the whole company's mobile directory
      @v1_message.employee_ids = @v1_message.company.employee_ids
    else

      # :employees_ids is a string list of ids ('1,2,3'), convert it into an array
      @v1_message.employee_ids = message_params[:employee_ids].split(",").map { |s| s.to_i }
    end

    if @v1_message.save
      send_sms_messages
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
    params.require(:message).permit(:company_id, :employee_ids, :question_id, :body)
  end

end
