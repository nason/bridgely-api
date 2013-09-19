class V1::SessionsController < ApplicationController
  before_filter :require_token, except: [:create]

  # before_filter :authenticate_v1_admin_user!, except: [:create]

  # respond_to :json

  # before_filter :ensure_params_exist

  def create
    resource = V1::Admin::User.find_by_email( session_params[:email] )

    return invalid_login_attempt unless resource

    if resource.valid_password?(session_params[:password])
      sign_in(:v1_admin_user, resource)
      render :json=> {:success=>true, :auth_token=>resource.authorization_token, :account => current_v1_admin_user }, status: :ok
      # TODO: Create a serializer for the account data in this response
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
