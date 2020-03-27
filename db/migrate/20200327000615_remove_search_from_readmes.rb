class RemoveSearchFromReadmes < ActiveRecord::Migration[6.0]
  def change

    remove_column :readmes, :search, :string
  end
end
