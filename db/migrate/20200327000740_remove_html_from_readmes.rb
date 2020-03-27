class RemoveHtmlFromReadmes < ActiveRecord::Migration[6.0]
  def change

    remove_column :readmes, :html, :string
  end
end
