class AddProjectStories < ActiveRecord::Migration
  def self.up
    remove_column :works, :task_id
    add_column :works, :project_id, :integer
    add_column :works, :story_id, :integer
  end

  def self.down
    add_column :works, :task_id, :integer
    remove_column :works, :project_id
    remove_column :works, :story_id
  end
end
