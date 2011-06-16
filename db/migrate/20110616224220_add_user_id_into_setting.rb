class AddUserIdIntoSetting < ActiveRecord::Migration
  def self.up
    add_column :settings, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :settings, :user_id
  end
end
