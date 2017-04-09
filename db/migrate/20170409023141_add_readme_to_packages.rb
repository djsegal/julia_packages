class AddReadmeToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :readme, :text
  end
end
