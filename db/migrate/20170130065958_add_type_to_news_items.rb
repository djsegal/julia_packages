class AddTypeToNewsItems < ActiveRecord::Migration[5.0]
  def change
    add_column :news_items, :type, :string
  end
end
