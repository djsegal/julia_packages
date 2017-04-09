class AddIsShallowToDependencies < ActiveRecord::Migration[5.0]
  def change
    add_column :dependencies, :is_shallow, :boolean
  end
end
