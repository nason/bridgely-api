# TODO: Move subaccount creation and phone number provision into seperate method, called via a before fiter on #create
# TODO: Save subaccount auth_token to db on subaccount creation
# TODO: Check autoresponder and other settings
# TODO: Better error handling on create

class V1::Admin::CompaniesController < ApplicationController
  before_filter :require_token
  before_filter :create_twilio_client, only: [:create, :destroy]

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

    @v1_admin_company = V1::Admin::Company.new(company_params.except(:users))

    # Create a subaccount for the company
    @subaccount = @twilio_client.accounts.create( :friendly_name => company_params[:name] )

    # Purchase the first available US phone number for the subaccount.
    # Use the Bridgely Twilio App SID to configure all numbers to callback the same resources;
    # This could be done on a per-account basis in the future.
    @number = @subaccount.available_phone_numbers.get('US').local.list.first.phone_number
    @subaccount.incoming_phone_numbers.create(
      :phone_number => @number,
      :sms_application_sid => TWILIO_APP_SID
    )

    # Store the company's account_sid in DB
    @v1_admin_company.account_sid = @subaccount.sid

    # Store the company's twilio phone in settings
    @v1_admin_company.settings = @v1_admin_company.settings.merge( { :account_phone_number => @number } )

    if @v1_admin_company.save
      @v1_admin_company.users.create company_params[:users]
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
      render json: @v1_admin_company, status: :ok
    else
      render json: @v1_admin_company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/admin/companies/1
  # DELETE /v1/admin/companies/1.json
  def destroy

    # TODO: Transfer number to main account? Or delete it?
    # TODO: Delete or suspend subaccount?

    @v1_admin_company = V1::Admin::Company.find(params[:id])
    @v1_admin_company.destroy

    head :no_content
  end

  private
  def company_params
    params.require(:company).permit(:name, :settings => [:autoresponder], :users => [:email, :password, :name])
  end
end
