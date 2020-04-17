puts "\nPackages"

user_dict = {}

package_list = []

bar = ProgressBar.new(@packages_db.size)

@packages_db.each(:row) do |cur_row|
  bar.increment!
  next if cur_row["package"] == "julia"

  user_name, user_key = cur_row["owner"], cur_row["owner"].to_s.downcase
  raise 'hell' if user_key.blank?

  if user_dict.has_key? user_key
    package_owner = user_dict[user_key]
  else
    package_owner = User.create name: user_name
    user_dict[user_key] = package_owner
  end

  package_list << Package.new(
    user: package_owner,
    name: cur_row["package"].upcase_first(),
    website: cur_row["homepage"],
    stars: cur_row["stars"],
    created: cur_row["created"],
    updated: cur_row["updated"],
    github_url: cur_row["github_url"],
    registered: cur_row["registered"],
    description: ( cur_row["description"] || "" ).upcase_first()
  )
end

Package.import package_list, batch_size: 512

User.find_each { |user| User.reset_counters(user.id, :packages) }

puts ""
