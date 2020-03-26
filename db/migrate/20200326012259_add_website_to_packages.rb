class AddWebsiteToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :website, :string
  end
end
