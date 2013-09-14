class CreateV1Employees < ActiveRecord::Migration
  def change
    create_table :v1_employees do |t|
      t.integer :company_id,        null: false
      t.string :phone,              null: false
      t.string :name,               null: false
      t.string :data

      t.timestamps
    end
    add_index :v1_employees, :company_id
    add_index :v1_employees, :phone
    add_index :v1_employees, :name
  end
end
