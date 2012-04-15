class ChangeNameSettings < ActiveRecord::Migration
  def self.up
    rename_column(:settings, :APIkey, :setting_value)
  end

  def self.down
    rename_column(:settings, :APIkey, :setting_value)
  end
end
