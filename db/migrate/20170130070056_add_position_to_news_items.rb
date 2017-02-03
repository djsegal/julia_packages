class AddPositionToNewsItems < ActiveRecord::Migration[5.0]
  def change
    add_column :news_items, :position, :integer
    add_index :news_items, :position
  end
end
