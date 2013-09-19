class ChangeSettingsInV1AdminCompany < ActiveRecord::Migration
  def self.up
    change_column :v1_admin_companies, :settings, 'text'
  end

  def self.down
    change_column :v1_admin_companies, :settings, 'string'
  end
end
