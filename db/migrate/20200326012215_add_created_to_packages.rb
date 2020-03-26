class AddCreatedToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :created, :datetime
  end
end
