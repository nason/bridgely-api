# TODO: Setup serializer

class V1::QuestionsController < ApplicationController
  before_filter :require_token
  before_filter :create_twilio_client, only: [:create]

  # GET /v1/questions
  # Return all questions
  def index

    if @current_user.admin?
      @v1_questions = V1::Question.all
    else
      @v1_questions = V1::Question.all.where(company: @current_user.company)
    end

    render json: @v1_questions
  end

  def employee_index
    @v1_question = V1::Question.find(params[:question_id])
    if @current_user.admin? or @current_user.company.id == @v1_question.message.company_id.to_i
      @v1_employees = @v1_question.message.employees
      render json: @v1_employees
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end
  end

  # GET /v1/questions/1
  # Find and return a single question by id
  def show
    @v1_question = V1::Question.find(params[:id])

    render json: @v1_question
  end

  # POST /v1/questions
  # Send an outgoing SMS message that is a question
  def create

    @v1_question = V1::Question.new(question_params.except(:message))
    @v1_message = @v1_question.build_message question_params[:message].except(:employee_ids)

    if question_params[:message][:employee_ids] === 'all'

      # If :employee_ids param is 'all', send to the whole company's mobile directory
      @v1_message.employee_ids = @v1_message.company.employee_ids
    else

      # :employees_ids is a string list of ids ('1,2,3'), convert it into an array
      @v1_message.employee_ids = question_params[:message][:employee_ids].split(",").map { |s| s.to_i }
    end
    @v1_message.save
    @v1_question.message_id = @v1_message.id

    if @v1_question.save
      send_sms_messages
      render json: @v1_question, status: :created, location: @v1_question
    else
      render json: @v1_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/questions/1
  # Update an existing question record
  def update
    @v1_question = V1::Question.find(params[:id])

    if @v1_question.update(question_params)
      render json: @v1_question, status: :ok
    else
      render json: @v1_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/questions/1
  # Delete a question record
  def destroy
    @v1_question = V1::Question.find(params[:id])
    @v1_question.destroy

    head :no_content
  end

  private
  def question_params
    params.require(:question).permit( :title, :response_tag, :message => [:company_id, :body, :employee_ids] )
  end
end
