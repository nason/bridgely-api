class CreateV1Messages < ActiveRecord::Migration
  def change
    create_table :v1_messages do |t|
      t.integer :company_id,          null: false
      t.integer :employee_id,         null: false
      t.integer :question_id
      t.string :body,                 null: false
      t.string :data
      t.string :direction,            null: false
      t.string :status,               default: "pending",  null: false

      t.timestamps
    end
    add_index :v1_messages, :company_id
    add_index :v1_messages, :employee_id
    add_index :v1_messages, :question_id
  end
end
