class ChangeV1Questions < ActiveRecord::Migration
  def change
    add_column :v1_questions, :message_id, :integer
    add_index :v1_questions, :message_id

    rename_column :v1_questions, :question, :title
  end
end
