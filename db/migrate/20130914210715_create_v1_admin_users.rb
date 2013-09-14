class CreateV1AdminUsers < ActiveRecord::Migration
  def change
    create_table :v1_admin_users do |t|
      t.string   "name"
      t.integer  "company_id"
      t.boolean  "admin",                  default: false
      t.string   "email"
      t.string   "encrypted_password"

      t.timestamps
    end
    add_index :v1_admin_users, :email
    add_index :v1_admin_users, :company_id
  end
end
