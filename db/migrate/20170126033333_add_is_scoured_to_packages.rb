class AddIsScouredToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :is_scoured, :boolean
    add_index :packages, :is_scoured
  end
end
