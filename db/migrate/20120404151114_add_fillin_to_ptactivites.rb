class AddFillinToPtactivites < ActiveRecord::Migration
  def self.up
    add_column :pt_activities, :fill_in, :boolean
  end

  def self.down
    remove_column :pt_activities, :fill_in
  end
end
