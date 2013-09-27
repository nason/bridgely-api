class AddCompanyIdAndSubaccountAuthTokenToV1AdminCompany < ActiveRecord::Migration
  def change
    add_column :v1_admin_companies, :short_name, :string
    add_column :v1_admin_companies, :sub_auth_token, :string

    add_index :v1_admin_companies, :short_name
  end
end
