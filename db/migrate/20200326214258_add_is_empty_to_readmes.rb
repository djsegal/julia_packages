class AddIsEmptyToReadmes < ActiveRecord::Migration[6.0]
  def change
    add_column :readmes, :is_empty, :boolean
  end
end
