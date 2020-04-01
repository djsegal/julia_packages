puts "\nReadmes"

readme_list = []

@all_packages.each_with_progress do |cur_package|
  package_name = cur_package.name.downcase

  cur_search_text = File.read("#{@julia_pkg_dir}/data/readme_search/" + package_name + ".txt")
  is_empty = cur_search_text.blank?

  cur_search_text = cur_search_text.prepend cur_package.name.downcase, " "
  cur_search_text = cur_search_text.prepend cur_package.description.downcase, " "

  cur_package.update! search: cur_search_text

  readme_list << Readme.new(
    package: cur_package,
    html: File.read("#{@julia_pkg_dir}/data/readme_html/" + package_name + ".txt"),
    is_empty: is_empty
  )
end

Readme.import readme_list, batch_size: 512

puts ""
