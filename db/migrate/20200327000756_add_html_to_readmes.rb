class AddHtmlToReadmes < ActiveRecord::Migration[6.0]
  def change
    add_column :readmes, :html, :text
  end
end
