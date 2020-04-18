class AddSubCategoryToSuggestions < ActiveRecord::Migration[6.0]
  def change
    add_reference :suggestions, :sub_category, null: false, foreign_key: { to_table: 'categories' }
  end
end
