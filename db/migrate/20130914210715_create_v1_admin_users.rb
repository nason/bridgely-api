class CreateV1AdminUsers < ActiveRecord::Migration
  def change
    create_table :v1_admin_users do |t|
      t.string   "name",                   null: false
      t.integer  "company_id",             null: false
      t.boolean  "admin",                  default: false, null: false
      t.string   "email",                  null: false
      t.string   "encrypted_password",     null: false

      t.timestamps
    end
    add_index :v1_admin_users, :email
    add_index :v1_admin_users, :company_id
  end
end
