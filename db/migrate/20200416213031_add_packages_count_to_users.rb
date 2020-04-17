class AddPackagesCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :packages_count, :integer
    add_index :users, :packages_count
  end
end
