class RemoveReadmeFromPackages < ActiveRecord::Migration[6.0]
  def change
    remove_column :packages, :readme, :string
  end
end
