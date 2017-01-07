class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.text :commits
      t.references :package, foreign_key: true

      t.timestamps
    end
  end
end
