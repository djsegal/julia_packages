class CreateRepositories < ActiveRecord::Migration[5.0]
  def change
    create_table :repositories do |t|
      t.references :package, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
