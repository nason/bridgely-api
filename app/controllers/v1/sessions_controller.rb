class V1::SessionsController < ApplicationController
  before_filter :require_token, except: [:create]

  def create
    resource = V1::Admin::User.find_by_email( session_params[:email] )

    return invalid_login_attempt unless resource

    if resource.valid_password?(session_params[:password])
      sign_in(:v1_admin_user, resource)
      render json: resource
    else
      invalid_login_attempt
    end

  end

  def destroy
    if @current_user
      sign_out(current_v1_admin_user)
      render :json => { success: true }, status: :ok if @current_user.update_attribute(:authorization_token, nil)
    else
      # This shouldnt ever happen, but just in case
      invalid_logout_attempt
    end
  end

  protected
  def session_params
    params.require(:session).permit(:email, :password)
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :errors=>"Invalid login or password"}, :status=>401
  end

  def invalid_logout_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :errors=>"Invalid logout request"}, :status=>422
  end

end
