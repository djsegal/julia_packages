class RemoveCreatedFromInfo < ActiveRecord::Migration[5.0]
  def change
    remove_column :infos, :created, :datetime
  end
end
