class AddIsRegisteredToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :is_registered, :boolean
    add_index :packages, :is_registered
  end
end
