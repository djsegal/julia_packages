class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.references :category, foreign_key: true
      t.references :package, foreign_key: true

      t.timestamps
    end

    add_index :labels, [:category_id, :package_id], unique: true, name: 'index_labels_on_uniqueness'
  end
end
