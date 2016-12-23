class AddCreatedToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :created, :datetime
  end
end
