class ApplicationController < ActionController::API
  # These are required to get rails-api to work correctly with strong parameters
  include ActionController::ParamsWrapper
  include ActionController::StrongParameters
end
