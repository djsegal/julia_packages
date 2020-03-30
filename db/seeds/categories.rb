puts "\nCategories"

category_names = $category_map.keys
sub_category_names = $category_map.values.flatten

category_package_names_list = category_names.map {
  |cur_name| @decibans_db.filter(:row) do |cur_row|
    cur_row["category"] == cur_name
  end
}.map(&:package).map(&:to_a)

sub_category_package_names_list = sub_category_names.map {
  |cur_name| @decibans_db.filter(:row) do |cur_row|
    cur_row["sub_category"] == cur_name
  end
}.map(&:package).map(&:to_a)

bar = ProgressBar.new(1 + category_names.length + sub_category_names.length)

bar.increment!
trending_packages = Package.where(name: @trending_db["package"].to_a)
Category.create! name: "Trending", packages: trending_packages

category_names.zip(category_package_names_list) do |category_name, category_package_names|
  bar.increment!
  category_packages = Package.where(name: category_package_names)

  Category.create! \
    name: category_name, \
    packages: category_packages
end

sub_category_names.zip(sub_category_package_names_list) do |sub_category_name, sub_category_packages_names|
  bar.increment!
  next if $sub_category_map[sub_category_name] == sub_category_name

  sub_category_packages = Package.where(name: sub_category_packages_names)

  Category.create! \
    name: sub_category_name, \
    packages: sub_category_packages
end

puts ""
