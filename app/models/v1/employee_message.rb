class V1::EmployeeMessage < ActiveRecord::Base
  validates :v1_employee_id, presence: true

  # TODO: Associations?
end
