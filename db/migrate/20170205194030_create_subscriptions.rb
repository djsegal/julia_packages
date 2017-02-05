class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :feed, foreign_key: true
      t.references :news_item, foreign_key: true

      t.timestamps
    end
  end
end
