class V1::QuestionsController < ApplicationController
  # GET /v1/questions
  # GET /v1/questions.json
  def index
    @v1_questions = V1::Question.all

    render json: @v1_questions
  end

  # GET /v1/questions/1
  # GET /v1/questions/1.json
  def show
    @v1_question = V1::Question.find(params[:id])

    render json: @v1_question
  end

  # POST /v1/questions
  # POST /v1/questions.json
  def create
    @v1_question = V1::Question.new(params[:v1_question])

    if @v1_question.save
      render json: @v1_question, status: :created, location: @v1_question
    else
      render json: @v1_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/questions/1
  # PATCH/PUT /v1/questions/1.json
  def update
    @v1_question = V1::Question.find(params[:id])

    if @v1_question.update(params[:v1_question])
      head :no_content
    else
      render json: @v1_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/questions/1
  # DELETE /v1/questions/1.json
  def destroy
    @v1_question = V1::Question.find(params[:id])
    @v1_question.destroy

    head :no_content
  end
end
