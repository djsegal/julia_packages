class CreateBlurbs < ActiveRecord::Migration[5.0]
  def change
    create_table :blurbs do |t|
      t.text :cargo

      t.timestamps
    end
  end
end
