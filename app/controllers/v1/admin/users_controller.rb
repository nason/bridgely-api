class V1::Admin::UsersController < ApplicationController
  # GET /v1/admin/users
  # GET /v1/admin/users.json
  def index
    @v1_admin_users = V1::Admin::User.all

    render json: @v1_admin_users
  end

  # GET /v1/admin/users/1
  # GET /v1/admin/users/1.json
  def show
    @v1_admin_user = V1::Admin::User.find(params[:id])

    render json: @v1_admin_user
  end

  # POST /v1/admin/users
  # POST /v1/admin/users.json
  def create
    @v1_admin_user = V1::Admin::User.new(user_params)

    if @v1_admin_user.save
      render json: @v1_admin_user, status: :created, location: @v1_admin_user
    else
      render json: @v1_admin_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/admin/users/1
  # PATCH/PUT /v1/admin/users/1.json
  def update
    @v1_admin_user = V1::Admin::User.find(params[:id])
    # TODO strip :company_id and maybe :encrypted_password out of params here
    if @v1_admin_user.update(user_params)
      render json: @v1_admin_user, status: :ok
    else
      render json: @v1_admin_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/admin/users/1
  # DELETE /v1/admin/users/1.json
  def destroy
    if @v1_admin_user = V1::Admin::User.find(params[:id])
      @v1_admin_user.destroy
      head :ok
    else
      head :bad_request
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :company_id, :encryped_password)
  end
end
