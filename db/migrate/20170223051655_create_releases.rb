class CreateReleases < ActiveRecord::Migration[5.0]
  def change
    create_table :releases do |t|
      t.string :tag_name
      t.datetime :published_at

      t.timestamps
    end
    add_index :releases, :published_at
  end
end
