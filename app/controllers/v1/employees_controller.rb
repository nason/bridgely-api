class V1::EmployeesController < ApplicationController
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
    @v1_employee = V1::Employee.new(params[:v1_employee])

    if @v1_employee.save
      render json: @v1_employee, status: :created, location: @v1_employee
    else
      render json: @v1_employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/employees/1
  # PATCH/PUT /v1/employees/1.json
  def update
    @v1_employee = V1::Employee.find(params[:id])

    if @v1_employee.update(params[:v1_employee])
      head :no_content
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
end
