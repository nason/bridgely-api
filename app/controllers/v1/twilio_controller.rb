class V1::TwilioController < ApplicationController

  # POST /v1/twilio/inbound

  def create
    # @v1_twilio = V1::Twilio.new(params[:v1_twilio])

    # if @v1_twilio.save
    #   render json: @v1_twilio, status: :created, location: @v1_twilio
    # else
    #   render json: @v1_twilio.errors, status: :unprocessable_entity
    # end

    puts params

  end

  # PATCH/PUT /v1/twilio/status

  def update
    # @v1_twilio = V1::Twilio.find(params[:id])

    # if @v1_twilio.update(params[:v1_twilio])
    #   head :no_content
    # else
    #   render json: @v1_twilio.errors, status: :unprocessable_entity
    # end

    puts params
  end

end
