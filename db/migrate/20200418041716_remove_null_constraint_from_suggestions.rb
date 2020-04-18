class RemoveNullConstraintFromSuggestions < ActiveRecord::Migration[6.0]
  def change
    change_column_null :suggestions, :sub_category_id, true
  end
end
