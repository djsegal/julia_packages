# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

general_db = Daru::DataFrame.from_csv "../JuliaPackages/data/general.csv"

general_db["shallow"].map! { |cur_value| cur_value.include?("[]") ? [] : JSON.parse(cur_value) }
general_db["deep"].map! { |cur_value| cur_value.include?("[]") ? [] : JSON.parse(cur_value) }

decibans_db = Daru::DataFrame.from_csv "../JuliaPackages/data/decibans.csv"
packages_db = Daru::DataFrame.from_csv "../JuliaPackages/data/packages.csv"
trending_db = Daru::DataFrame.from_csv "../JuliaPackages/data/trending.csv"

package_list = []

packages_db.each(:row) do |cur_row|
  next if cur_row["package"] == "julia"

  package_list << Package.new(
    name: cur_row["package"].upcase_first(),
    website: cur_row["homepage"],
    owner: cur_row["owner"],
    stars: cur_row["stars"],
    created: cur_row["created"],
    updated: cur_row["updated"],
    github_url: cur_row["github_url"],
    description: ( cur_row["description"] || "" ).upcase_first()
  )
end

Package.destroy_all
Package.import package_list, batch_size: 512

readme_list = []

Package.all.each do |cur_package|
  package_name = cur_package.name.downcase

  cur_search_text = File.read("../JuliaPackages/data/readme_search/" + package_name + ".txt")
  is_empty = cur_search_text.blank?

  cur_search_text = cur_search_text.prepend cur_package.name.downcase, " "
  cur_search_text = cur_search_text.prepend cur_package.description.downcase, " "

  cur_package.update! search: cur_search_text

  readme_list << Readme.new(
    package: cur_package,
    html: File.read("../JuliaPackages/data/readme_html/" + package_name + ".txt"),
    is_empty: is_empty
  )
end

Readme.destroy_all
Readme.import readme_list, batch_size: 512

Category.destroy_all

trending_packages = Package.where(name: trending_db["package"].to_a)
Category.create! name: "Trending", packages: trending_packages

category_names = $category_map.keys
sub_category_names = $category_map.values.flatten

category_package_names_list = category_names.map {
  |cur_name| decibans_db.filter(:row) do |cur_row|
    cur_row["category"] == cur_name
  end
}.map(&:package).map(&:to_a)

sub_category_package_names_list = sub_category_names.map {
  |cur_name| decibans_db.filter(:row) do |cur_row|
    cur_row["sub_category"] == cur_name
  end
}.map(&:package).map(&:to_a)

category_names.zip(category_package_names_list) do |category_name, category_package_names|
  category_packages = Package.where(name: category_package_names)

  Category.create! \
    name: category_name, \
    packages: category_packages
end

sub_category_names.zip(sub_category_package_names_list) do |sub_category_name, sub_category_packages_names|
  next if $sub_category_map[sub_category_name] == sub_category_name

  sub_category_packages = Package.where(name: sub_category_packages_names)

  Category.create! \
    name: sub_category_name, \
    packages: sub_category_packages
end
