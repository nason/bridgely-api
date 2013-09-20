class UpdateMessagesQuestionsEmployeeTablesParty < ActiveRecord::Migration
  def self.up
    remove_column :v1_messages, :data
    change_column :v1_messages, :direction, :string, :default => "outbound"

    remove_column :v1_questions, :company_id

    change_column :v1_employees, :data, :text, :limit => nil
  end

  def self.down
    # Leaves v1_messages:direction default and v1_employees:data type
    add_column :v1_messages, :data

    add_column :v1_questions, :company_id
    add_index :v1_questions, :company_id
  end
end
