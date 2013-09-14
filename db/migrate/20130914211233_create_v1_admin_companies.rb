class CreateV1AdminCompanies < ActiveRecord::Migration
  def change
    create_table :v1_admin_companies do |t|
      t.string :name,             null: false
      t.string :settings

      t.timestamps
    end
    add_index :v1_admin_companies, :name
  end
end
