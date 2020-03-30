class CreateDependencies < ActiveRecord::Migration[6.0]
  def change
    create_table :dependencies do |t|
      t.references :depender, null: false, foreign_key: { to_table: 'packages' }
      t.references :dependee, null: false, foreign_key: { to_table: 'packages' }
      t.boolean :shallow

      t.timestamps
    end
  end
end
