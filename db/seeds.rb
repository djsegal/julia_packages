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

package_list = []

packages_db.each(:row) do |cur_row|
  package_list << Package.new(
    name: cur_row["package"],
    website: cur_row["homepage"],
    owner: cur_row["owner"],
    stars: cur_row["stars"],
    created: cur_row["created"],
    updated: cur_row["updated"],
    github_url: cur_row["github_url"],
    description: cur_row["description"]
  )
end

Package.destroy_all
Package.import package_list, batch_size: 512

readme_list = []

Package.all.each do |cur_package|
  package_name = cur_package.name.downcase

  readme_list << Readme.new(
    package: cur_package,
    html: File.read("../JuliaPackages/data/readme_html/" + package_name + ".txt"),
    search: File.read("../JuliaPackages/data/readme_search/" + package_name + ".txt")
  )
end

Readme.destroy_all
Readme.import readme_list, batch_size: 512
