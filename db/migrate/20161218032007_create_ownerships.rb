class CreateOwnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t|
      t.references :user, foreign_key: true
      t.references :package, foreign_key: true

      t.timestamps
    end
    add_index :ownerships, [:user_id, :package_id], unique: true, name: 'index_ownerships_on_uniqueness'
    add_index :ownerships, [:package_id], unique: true, name: 'index_ownerships_on_package_uniqueness'
  end
end
