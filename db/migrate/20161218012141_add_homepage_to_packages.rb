class AddHomepageToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :homepage, :string
  end
end
