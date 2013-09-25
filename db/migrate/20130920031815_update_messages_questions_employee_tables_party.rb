class UpdateMessagesQuestionsEmployeeTablesParty < ActiveRecord::Migration
  def change
    remove_column :v1_messages, :data
    remove_column :v1_messages, :status
    remove_column :v1_messages, :message_sid

    change_column :v1_messages, :direction, :string, :default => "outbound"

    remove_column :v1_messages, :employee_id

    remove_column :v1_questions, :company_id

    change_column :v1_employees, :data, :text, :limit => nil
  end
end
