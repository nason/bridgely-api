class AddTwilioToV1AdminCompany < ActiveRecord::Migration
  def self.up
    change_table(:v1_admin_companies) do |t|
      t.string :account_sid
    end
    add_index :v1_admin_companies, :account_sid
  end
  def self.down
    remove_column :v1_admin_companies, :account_sid
    remove_index :v1_admin_companies, :account_sid
  end
end
