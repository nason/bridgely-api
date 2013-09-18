class V1::SessionsController < ApplicationController
  before_filter :authenticate_v1_admin_user!, except: [:create]
  before_filter :require_token, except: [:create]
  # before_filter :ensure_user_login_param_exists, only: [:create]
  # before_filter :ensure_email_param_exists, only: [:create]
  # before_filter :ensure_password_param_exists, only: [:create]
  # respond_to :json

  # before_filter :ensure_params_exist

  def create
    # build_resource
    resource = V1::Admin::User.find_by_email( session_params[:email] )
    return invalid_login_attempt unless resource

    if resource.valid_password?(session_params[:password])
      sign_in(resource_name, resource)
      resource.ensure_authentication_token!
      render :json=> {:success=>true, :auth_token=>resource.authentication_token, :account=>resource.email}, status: :created
      return
    end
    invalid_login_attempt
  end

  def destroy
    current_user.reset_authentication_token
    # current_user.authentication_token = nil
    # resource.save
    render json: { success: true }, status: :ok
  end

  protected
  def session_params
    params.require(:session).permit(:email, :password)
  end

  # def ensure_param_exists(param)
  #   return unless employee_params[param].blank?
  #   render json:{ success: false, message: "Missing #{param}"}, status: :unprocessable_entity
  # end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end

end
