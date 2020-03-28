class AddSlugToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :slug, :string
    add_index :packages, :slug, unique: true
  end
end
