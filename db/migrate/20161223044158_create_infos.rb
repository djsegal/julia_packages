class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.integer :repos
      t.integer :followers
      t.integer :following
      t.datetime :created
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
