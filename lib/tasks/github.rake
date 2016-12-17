namespace :github do

  github_directory = 'tmp/github'

  desc "download github package information"
  task download: :environment do
    non_github_packages = []

    Package.all.each do |package|
      parsed_url = package.url[/(?<=github.com\/).*(?=.git)/]

      unless parsed_url.present?
        non_github_packages << package
        next
      end

      user_name, repo_name = parsed_url.split '/'

      github = Github.new oauth_token: ENV['GITHUB_TOKEN']
      information = github.repos.get(user_name, repo_name).body

      is_moved_repository = ( information.message == "Moved Permanently" )

      if is_moved_repository
        non_github_packages << package
        information = HTTParty.get(information.url)
      end

      package_directory = "#{Rails.root}/#{github_directory}/#{package.name}"

      FileUtils.mkdir_p(package_directory) \
        unless File.directory? package_directory

      File.open("#{github_directory}/#{package.name}/data.yml",'w') do |h|
         h.write information.to_yaml
      end
    end

    puts non_github_packages.map &:url
  end

  desc "TODO"
  task unpack: :environment do
    skipped_packages = []

    Package.all.each do |package|
      package_directory = "#{github_directory}/#{package.name}"

      unless File.directory? package_directory
        skipped_packages << package
        next
      end

      information = YAML.load_file("#{package_directory}/data.yml")

      package.update description: information['description']

      make_counter package, information
    end

    puts skipped_packages.map &:name
  end

  def make_counter package, information
    columns = clean_field_list Counter.column_names

    counter_hash = { package: package }
    columns.each do |column|
      counter_hash[column.to_sym] = information["#{column.pluralize}_count"]
    end

    Counter.create! counter_hash
  end

end
