class AddLabelsCountToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :labels_count, :integer
    add_index :categories, :labels_count
  end
end
