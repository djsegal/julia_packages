class RemoveFuzzyMatchSearch < ActiveRecord::Migration[6.0]
  def self.up
    ActiveRecord::Base.connection.execute("DROP EXTENSION IF EXISTS pg_trgm;")
    ActiveRecord::Base.connection.execute("DROP EXTENSION IF EXISTS fuzzystrmatch;")
  end

  def self.down
    ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS pg_trgm;")
    ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;")
  end
end
