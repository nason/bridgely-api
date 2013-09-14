class CreateV1Questions < ActiveRecord::Migration
  def change
    create_table :v1_questions do |t|
      t.string :company_id,         null: false
      t.string :question,           null: false
      t.string :response_tag

      t.timestamps
    end
    add_index :v1_questions, :company_id
    add_index :v1_questions, :response_tag
  end
end
