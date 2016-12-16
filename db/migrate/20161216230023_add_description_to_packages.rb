class AddDescriptionToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :description, :string
  end
end
