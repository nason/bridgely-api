class ApplicationController < ActionController::API
  # These are required to get rails-api to work correctly with strong parameters
  include ActionController::ParamsWrapper
  include ActionController::StrongParameters


  # This could be used to setup token authentication
  # include ActionController::HttpAuthentication::Token::ControllerMethods

  # before_filter :require_token

  # private

  # def require_token
  #   authenticate_or_request_with_http_token do |key, options|
  #     @current_user = Token.find_by_key(key).account if Token.exists?(key: key)
  #   end
  # end
end
