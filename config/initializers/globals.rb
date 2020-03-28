decibans_db = Daru::DataFrame.from_csv "../JuliaPackages/data/decibans.csv"

category_names = decibans_db.category.to_a.uniq.sort
sub_category_names = decibans_db.sub_category.to_a.select(&:present?).uniq.sort

category_tables = category_names.map {
  |cur_name| decibans_db.filter(:row) do |cur_row|
    cur_row["category"] == cur_name
  end
}

sub_category_tables = sub_category_names.map {
  |cur_name| decibans_db.filter(:row) do |cur_row|
    cur_row["sub_category"] == cur_name
  end
}

category_package_names_list = category_tables.map(&:package).map(&:to_a)
sub_category_package_names_list = sub_category_tables.map(&:package).map(&:to_a)

$category_tree = Hash[
  category_names.zip category_tables.map(&:sub_category).map(&:to_a).map(&:uniq).map{ |cur_list| cur_list.select(&:present?) }.map(&:sort)
]
