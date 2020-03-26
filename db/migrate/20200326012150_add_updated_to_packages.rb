class AddUpdatedToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :updated, :datetime
  end
end
