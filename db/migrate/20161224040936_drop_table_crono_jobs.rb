class DropTableCronoJobs < ActiveRecord::Migration[5.0]
  def up
    drop_table :crono_jobs
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
