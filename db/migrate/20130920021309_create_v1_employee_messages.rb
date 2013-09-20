class CreateV1EmployeeMessages < ActiveRecord::Migration
  def change

    create_join_table :v1_employees, :v1_messages, column_options: {null: true} do |t|
      t.integer :v1_question_id
      t.string :message_sid,  null: false, default: "pending"
      t.index :v1_employee_id
      t.index :v1_message_id
      t.index :v1_question_id
    end

  end
end
