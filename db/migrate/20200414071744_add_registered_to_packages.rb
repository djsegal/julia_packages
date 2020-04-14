class AddRegisteredToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :registered, :bool
  end
end
