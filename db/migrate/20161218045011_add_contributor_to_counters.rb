class AddContributorToCounters < ActiveRecord::Migration[5.0]
  def change
    add_column :counters, :contributor, :integer
  end
end
