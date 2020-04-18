class AddUniqueIndexToSuggestions < ActiveRecord::Migration[6.0]
  def change
    add_index :suggestions, [:package_id, :category_id, :sub_category_id],
      unique: true, name: "unique_combination_index"
  end
end
