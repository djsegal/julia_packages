class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :nickname
      t.string :company
      t.string :blog
      t.string :location
      t.string :bio
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
