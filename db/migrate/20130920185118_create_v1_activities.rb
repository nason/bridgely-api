class CreateV1Activities < ActiveRecord::Migration
  def change
    create_table :v1_activities do |t|
      t.integer :employee_id
      t.integer :message_id
      t.integer :question_id
      t.string :message_sid,  null: false, default: "pending"
      t.string :sms_status,   null: false, default: "pending"
      t.index :employee_id
      t.index :message_id
      t.index :question_id
      t.index :message_sid
    end
  end
end
