class AddUserItToWork < ActiveRecord::Migration
  def self.up
    add_column :works, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :works, :user_id
  end
end
