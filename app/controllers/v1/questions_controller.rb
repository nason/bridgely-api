# TODO: Dont take question_id param, question controller will create question record and message record
# TODO: Determine the relationship path to tag an incoming message as a response to a question

class V1::QuestionsController < ApplicationController
  before_filter :require_token

  # TODO: Strip out unnecessary params
  # TODO: Setup serializer

  # GET /v1/questions
  # Return all questions
  def index
    @v1_questions = V1::Question.all

    render json: @v1_questions
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
    @v1_question = V1::Question.new(question_params)

    if @v1_question.save
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
  def message_params
    params.require(:question).permit(:question, :response_tag)
  end
end
