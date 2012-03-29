class CreatePtActivities < ActiveRecord::Migration
  def self.up
    create_table :pt_activities do |t|
      t.integer :activity_id
      t.integer :project_id
      t.integer :story_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :pt_activities
  end
end
