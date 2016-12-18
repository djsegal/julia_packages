class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.references :user, foreign_key: true
      t.references :package, foreign_key: true

      t.timestamps
    end
    add_index :contributions, [:user_id, :package_id], unique: true, name: 'index_contributions_on_uniqueness'
  end
end
