class RemoveOwnerFromPackages < ActiveRecord::Migration[6.0]
  def change

    remove_column :packages, :owner, :string
  end
end
