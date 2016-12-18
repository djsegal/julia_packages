class AddTouchedToDater < ActiveRecord::Migration[5.0]
  def change
    add_column :daters, :touched, :datetime
  end
end
