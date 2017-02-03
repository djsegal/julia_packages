class CreateNewsItems < ActiveRecord::Migration[5.0]
  def change
    create_table :news_items do |t|
      t.string :name
      t.references :target, polymorphic: true
      t.string :link

      t.timestamps
    end
  end
end
