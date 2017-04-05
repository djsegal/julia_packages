class AddPgTrgmExtensionToDb < ActiveRecord::Migration[5.0]

  def up
    if Rails.env.production?
      execute "CREATE EXTENSION pg_trgm;"
      execute "CREATE EXTENSION fuzzystrmatch;"
    end
  end

  def down
    if Rails.env.production?
      execute "DROP EXTENSION pg_trgm;"
      execute "DROP EXTENSION fuzzystrmatch;"
    end
  end

end


