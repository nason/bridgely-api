#TODO Delete this table

class CreateV1EmployeeMessages < ActiveRecord::Migration
  def change

    create_join_table :employees, :messages, table_name: :v1_employees_messages, column_options: {null: true} do |t|
      t.integer :question_id
      t.string :message_sid,  null: false, default: "pending"
      t.string :sms_status,   null: false, default: "pending"
      t.index :employee_id
      t.index :message_id
      t.index :question_id
    end

  end
end
