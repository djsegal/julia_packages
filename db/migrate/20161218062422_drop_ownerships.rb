class DropOwnerships < ActiveRecord::Migration[5.0]
  def change
    remove_index :ownerships, name: 'index_ownerships_on_uniqueness'
    remove_index :ownerships, name: 'index_ownerships_on_package_uniqueness'

    drop_table :ownerships do |t|
      t.references :user, foreign_key: true
      t.references :package, foreign_key: true

      t.timestamps null: false
    end
  end
end
