class AddGistsToInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :infos, :gists, :integer
  end
end
