class V1::EmployeesController < ApplicationController
  before_filter :require_token

  # GET /v1/employees
  # GET /v1/employees.json
  def index
    @v1_employees = V1::Employee.all

    render json: @v1_employees
  end

  # GET /v1/employees/1
  # GET /v1/employees/1.json
  def show
    @v1_employee = V1::Employee.find(params[:id])

    render json: @v1_employee
  end

  # POST /v1/employees
  # POST /v1/employees.json
  def create
    @v1_employee = V1::Employee.new(employee_params)

    if @v1_employee.save
      render json: @v1_employee, status: :created, location: @v1_employee
    else
      render json: @v1_employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/employees/1
  # PATCH/PUT /v1/employees/1.json
  def update
    # TODO Strip company_id out of params here
    @v1_employee = V1::Employee.find(params[:id])

    if @v1_employee.update_attributes(employee_params)
      render json: @v1_employee, status: :ok
    else
      render json: @v1_employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/employees/1
  # DELETE /v1/employees/1.json
  def destroy
    @v1_employee = V1::Employee.find(params[:id])
    @v1_employee.destroy

    head :no_content
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :phone, :company_id, :data)
  end
end
