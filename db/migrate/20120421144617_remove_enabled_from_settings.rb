class RemoveEnabledFromSettings < ActiveRecord::Migration
  def self.up
    remove_column :settings, :enabled
    
  end

  def self.down
    add_column :settings, :enabled
  end
end
