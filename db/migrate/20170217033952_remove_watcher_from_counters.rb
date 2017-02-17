class RemoveWatcherFromCounters < ActiveRecord::Migration[5.0]
  def change
    remove_column :counters, :watcher, :integer
  end
end
