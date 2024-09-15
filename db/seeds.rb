# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Array
  include ProgressBar::WithProgress
end

system "git -C #{@julia_pkg_dir} pull"
system "git -C #{@julia_pkg_dir} fetch --all"
system "git -C #{@julia_pkg_dir} reset origin --hard"

refresh_category_maps()

seed_target = ENV["SEED_TARGET"] || "all"  # Default to "all" if no target is provided

if seed_target == "readmes"
  raise 'hell' if Readme.count > 0
  raise 'hell' if Package.count == 0
else
  Label.delete_all
  Dependency.delete_all

  Readme.delete_all
  Category.delete_all

  Package.delete_all
  User.delete_all

  @general_db = Daru::DataFrame.from_csv "#{@julia_pkg_dir}/data/general.csv"

  @general_db["shallow_depending"].map! { |cur_value| cur_value.include?("[]") ? [] : JSON.parse(cur_value.gsub "'", '"') }
  @general_db["deep_depending"].map! { |cur_value| cur_value.include?("[]") ? [] : JSON.parse(cur_value.gsub "'", '"') }

  @general_db["shallow_dependents"].map! { |cur_value| cur_value.include?("[]") ? [] : JSON.parse(cur_value.gsub("'", '"').gsub(/(Any|String)\[/, "[")) }
  @general_db["deep_dependents"].map! { |cur_value| cur_value.include?("[]") ? [] : JSON.parse(cur_value.gsub("'", '"').gsub(/(Any|String)\[/, "[")) }

  @decibans_db = Daru::DataFrame.from_csv "#{@julia_pkg_dir}/data/decibans.csv"
  @chatgpt_db = Daru::DataFrame.from_csv "#{@julia_pkg_dir}/data/chatgpt.csv"

  @packages_db = Daru::DataFrame.from_csv "#{@julia_pkg_dir}/data/packages.csv"
  @trending_db = Daru::DataFrame.from_csv "#{@julia_pkg_dir}/data/trending.csv"

  package_seed_file = File.join(Rails.root, 'db', 'seeds', 'packages.rb')
  load package_seed_file
end

@all_packages = Package.all.to_a

seed_files = []

seed_files += Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')]
seed_files += Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')]

seed_files.reject! { |seed_file| seed_file == package_seed_file }

seed_files.sort!
  
if seed_target == "readmes"
  seed_files.select! { |seed_file| seed_file.include?("readmes") }
else
  seed_files.reject! { |seed_file| seed_file.include?("readmes") }
end
  
seed_files.each { |seed| load seed }
