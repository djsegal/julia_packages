puts "\nPackages"

package_list = []

bar = ProgressBar.new(@packages_db.size)

@packages_db.each(:row) do |cur_row|
  bar.increment!
  next if cur_row["package"] == "julia"

  package_list << Package.new(
    name: cur_row["package"].upcase_first(),
    website: cur_row["homepage"],
    owner: cur_row["owner"],
    stars: cur_row["stars"],
    created: cur_row["created"],
    updated: cur_row["updated"],
    github_url: cur_row["github_url"],
    registered: cur_row["registered"],
    description: ( cur_row["description"] || "" ).upcase_first()
  )
end

Package.import package_list, batch_size: 512

puts ""
