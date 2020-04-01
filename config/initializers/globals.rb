# seeds.rb independent

@julia_pkg_dir = File.join(Rails.root, 'tmp', 'JuliaPackages.jl')

unless Dir.exist? @julia_pkg_dir
  system "git clone https://github.com/djsegal/JuliaPackages.jl.git #{@julia_pkg_dir}"
end

decibans_db = Daru::DataFrame.from_csv "#{@julia_pkg_dir}/data/decibans.csv"

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

$category_map = Hash[
  category_names.zip category_tables.map(&:sub_category).map(&:to_a).map(&:uniq).map{ |cur_list| cur_list.select(&:present?) }.map(&:sort)
]

$category_map.each do |cur_key, cur_values|
  cur_values.reject! { |cur_value| cur_value == cur_key }
end

$sub_category_map = {}
$category_map.each do |cur_key, cur_values|
  cur_values.each do |cur_value|
    $sub_category_map[cur_value] = cur_key
  end
end

# seeds.rb dependent

is_migrated = true
begin
  Category.count
rescue
  is_migrated = false
end

if is_migrated

  all_categories = Category.where.not(name: "Trending").order(labels_count: :desc).to_a

  category_names = $category_map.keys
  category_list = all_categories.select { |cur_category| category_names.include? cur_category.name }

  sub_category_names = $category_map.values.flatten
  @sub_categories = all_categories.select { |cur_category| sub_category_names.include? cur_category.name }

  work_category_dict = {}

  category_list.each do |cur_category|
    cur_value = $category_map[cur_category.name]

    cur_sub_categories = @sub_categories.select do |tmp_category|
      cur_value.include? tmp_category.name
    end

    if ( cur_sub_categories.length < 2 )
      @sub_categories.reject! { |sub_category| cur_sub_categories.include? sub_category }
      cur_sub_categories = []
    end

    work_category_dict[cur_category] = cur_sub_categories
  end

  $sub_category_dict = {}

  work_category_dict.each do |cur_key, cur_values|
    cur_values.each do |cur_value|
      $sub_category_dict[cur_value.slug] = cur_key
    end
  end

  $category_dict = {}

  work_category_dict.each do |cur_key, cur_values|
    $category_dict[cur_key.slug] = cur_values
  end

end
