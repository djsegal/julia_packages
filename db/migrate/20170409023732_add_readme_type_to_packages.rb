class AddReadmeTypeToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :readme_type, :string
  end
end
