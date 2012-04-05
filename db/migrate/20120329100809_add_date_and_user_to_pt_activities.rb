class AddDateAndUserToPtActivities < ActiveRecord::Migration
  def self.up
    add_column :pt_activities, :day, :date
    add_column :pt_activities, :user, :string
  end

  def self.down
    remove_column :pt_activities, :user
    remove_column :pt_activities, :day
  end
end
