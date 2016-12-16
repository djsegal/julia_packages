class CreateCounters < ActiveRecord::Migration[5.0]
  def change
    create_table :counters do |t|
      t.integer :fork
      t.integer :stargazer
      t.integer :watcher
      t.integer :subscriber
      t.integer :open_issue
      t.references :package, foreign_key: true

      t.timestamps
    end
  end
end
