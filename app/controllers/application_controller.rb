class ApplicationController < ActionController::API
  include ActionController::ParamsWrapper
  include ActionController::StrongParameters
end
