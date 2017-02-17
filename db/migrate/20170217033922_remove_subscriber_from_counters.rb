class RemoveSubscriberFromCounters < ActiveRecord::Migration[5.0]
  def change
    remove_column :counters, :subscriber, :integer
  end
end
