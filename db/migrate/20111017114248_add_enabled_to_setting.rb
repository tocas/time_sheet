class AddEnabledToSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :enabled, :boolean
  end

  def self.down
    remove_column :settings, :enabled
  end
end
