# TODO: Refactor to schema update

class V1::Admin::UsersController < ApplicationController
  before_filter :require_token

  # GET /v1/admin/users
  # GET /v1/admin/users.json
  def index
    if @current_user.admin?
      @v1_admin_users = V1::Admin::User.all
    else
      @v1_admin_users = V1::Admin::User.where(company_id: @current_user.company.id)
    end

    render json: @v1_admin_users
  end

  # GET /v1/companies/1/users
  def company_index
    if @current_user.admin? or @current_user.company.id == params[:company_id].to_i
      @v1_admin_users = V1::Admin::User.where(company_id: params[:company_id])
      render json: @v1_admin_users
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end
  end

  # GET /v1/admin/users/1
  # GET /v1/admin/users/1.json
  def show
    @v1_admin_user = V1::Admin::User.find(params[:id])

    if @current_user.admin? or @current_user.company.id == @v1_admin_user.company.id
      render json: @v1_admin_user
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end
  end

  # POST /v1/admin/users
  # POST /v1/admin/users.json
  def create
    if @current_user.admin?
      @v1_admin_user = V1::Admin::User.new(user_params)

      if @v1_admin_user.save
        render json: @v1_admin_user, status: :created, location: @v1_admin_user
      else
        warden.custom_failure!
        render json: @v1_admin_user.errors, status: :unprocessable_entity
      end
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end
  end

  # PATCH/PUT /v1/admin/users/1
  # PATCH/PUT /v1/admin/users/1.json
  def update
    if @current_user.admin?
      @v1_admin_user = V1::Admin::User.find(params[:id])
      # TODO strip :company_id and maybe :encrypted_password out of params here
      if @v1_admin_user.update(user_params)
        render json: @v1_admin_user, status: :ok
      else
        render json: @v1_admin_user.errors, status: :unprocessable_entity
      end
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end
  end

  # DELETE /v1/admin/users/1
  # DELETE /v1/admin/users/1.json
  def destroy
    if @current_user.admin?
      if @v1_admin_user = V1::Admin::User.find(params[:id])
        @v1_admin_user.destroy
        head :ok
      else
        head :bad_request
      end
    else
      render json: {error: 'forbidden'}, status: :forbidden
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :company_id, :encryped_password)
  end
end
