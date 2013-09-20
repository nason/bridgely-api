require 'pry'
class ApplicationController < ActionController::API

  # These are required to get rails-api to work correctly with strong parameters
  include ActionController::ParamsWrapper
  include ActionController::StrongParameters

  # CORS Headers
  before_filter :cors

  # Add CSRF protection
  # include ActionController::RequestForgeryProtection

  # enable CSRF protection on all controllers
  # protect_from_forgery with: :reset_session

  # Setup token authentication
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # Enable Devise
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  def cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
    head(:ok) if request.request_method == "OPTIONS"

    # headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    # headers['Access-Control-Max-Age'] = '86400'
  end

  private

  def require_token
    authenticate_or_request_with_http_token do |key, options|
      @current_user = V1::Admin::User.find_by_authorization_token(key) if V1::Admin::User.exists?(authorization_token: key)
    end
  end

  def create_twilio_client

    # Instantiate twilio client if it doesn't already exist
    @twilio_client = Twilio::REST::Client.new( TWILIO_SID, TWILIO_AUTH_TOKEN ) if @twilio_client.nil?
  end

end
