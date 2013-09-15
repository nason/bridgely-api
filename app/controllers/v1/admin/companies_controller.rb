class V1::Admin::CompaniesController < ApplicationController

  # GET /v1/admin/companies
  # GET /v1/admin/companies.json
  def index
    @v1_admin_companies = V1::Admin::Company.all

    render json: @v1_admin_companies
  end

  # GET /v1/admin/companies/1
  # GET /v1/admin/companies/1.json
  def show
    @v1_admin_company = V1::Admin::Company.find(params[:id])

    render json: @v1_admin_company
  end

  # POST /v1/admin/companies
  # POST /v1/admin/companies.json
  def create

    @v1_admin_company = V1::Admin::Company.new(company_params)

    if @v1_admin_company.save
      render json: @v1_admin_company, status: :created, location: @v1_admin_company
    else
      render json: @v1_admin_company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/admin/companies/1
  # PATCH/PUT /v1/admin/companies/1.json
  def update

    @v1_admin_company = V1::Admin::Company.find(params[:id])

    if @v1_admin_company.update(company_params)
      head :ok
    else
      render json: @v1_admin_company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/admin/companies/1
  # DELETE /v1/admin/companies/1.json
  def destroy
    @v1_admin_company = V1::Admin::Company.find(params[:id])
    @v1_admin_company.destroy

    head :no_content
  end

  private
  def company_params
    params.require(:company).permit(:name, :settings)
  end
end
