class CreateDownloads < ActiveRecord::Migration[5.0]
  def change
    create_table :downloads do |t|
      t.string :name
      t.string :file

      t.timestamps
    end
  end
end
