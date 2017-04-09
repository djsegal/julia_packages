class RemovePgSearchDmetaphoneSupport < ActiveRecord::Migration[5.0]

  def up
    say_with_time("Dropping support functions for pg_search :dmetaphone") do
      execute <<-'SQL'
DROP FUNCTION pg_search_dmetaphone(text);
      SQL
    end

    execute "DROP EXTENSION fuzzystrmatch;"
  end

  def down
    execute "CREATE EXTENSION fuzzystrmatch;"

    say_with_time("Adding support functions for pg_search :dmetaphone") do
      execute <<-'SQL'
CREATE OR REPLACE FUNCTION pg_search_dmetaphone(text) RETURNS text LANGUAGE SQL IMMUTABLE STRICT AS $function$
  SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\\s+')))), ' ')
$function$;
      SQL
    end
  end

end
