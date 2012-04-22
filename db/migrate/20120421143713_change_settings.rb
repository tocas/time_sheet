class ChangeSettings < ActiveRecord::Migration
  def self.up
    rename_column(:settings, :name, :pt_api_key)
    rename_column(:settings, :setting_value, :pt_name)
  end

  def self.down
    rename_column(:settings, :pt_api_key, :name)
    rename_column(:settings, :pt_name, :setting_value)
  end
end
