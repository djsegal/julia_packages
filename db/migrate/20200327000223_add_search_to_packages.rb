class AddSearchToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :search, :text
  end
end
