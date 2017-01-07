class CreateBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :batches do |t|
      t.integer :marker
      t.references :item, polymorphic: true

      t.timestamps
    end
    add_index :batches, :marker
  end
end
