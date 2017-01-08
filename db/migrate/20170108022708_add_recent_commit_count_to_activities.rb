class AddRecentCommitCountToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :recent_commit_count, :integer
    add_index :activities, :recent_commit_count
  end
end
