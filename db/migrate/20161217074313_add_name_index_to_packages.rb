class AddNameIndexToPackages < ActiveRecord::Migration[5.0]
  def change
    add_index :packages, :name
  end
end
