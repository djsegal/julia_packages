class CreateDependencies < ActiveRecord::Migration[5.0]
  def change
    create_table :dependencies do |t|
      t.integer :dependent_id
      t.integer :depended_id

      t.timestamps
    end
    add_index :dependencies, :dependent_id
    add_index :dependencies, :depended_id
    add_index :dependencies, [:dependent_id, :depended_id], unique: true, name: 'index_dependencies_on_uniqueness'
  end
end
