class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.references :package, foreign_key: true
      t.integer :major
      t.integer :minor
      t.integer :patch
      t.string :sha1
      t.string :number

      t.timestamps
    end
  end
end
