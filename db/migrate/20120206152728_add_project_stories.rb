class AddProjectStories < ActiveRecord::Migration
  def self.up
    add_column :works, :project_id, :integer
    add_column :works, :story_id, :integer
  end

  def self.down
    remove_column :works, :project_id
    remove_column :works, :story_id
  end
end
