class CreateDaters < ActiveRecord::Migration[5.0]
  def change
    create_table :daters do |t|
      t.datetime :created
      t.datetime :updated
      t.datetime :pushed
      t.references :package, foreign_key: true

      t.timestamps
    end
  end
end
