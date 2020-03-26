class CreateReadmes < ActiveRecord::Migration[6.0]
  def change
    create_table :readmes do |t|
      t.string :html
      t.string :search
      t.references :package, null: false, foreign_key: true

      t.timestamps
    end
  end
end
