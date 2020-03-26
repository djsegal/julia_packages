class AddOwnerToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :owner, :string
  end
end
