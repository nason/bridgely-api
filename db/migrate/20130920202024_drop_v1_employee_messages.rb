class DropV1EmployeeMessages < ActiveRecord::Migration
  def change
    drop_table :v1_employees_messages
  end
end
