namespace :github do

  github_directory = 'tmp/github'

  desc "download github package information"
  task download: :environment do
    non_github_packages = []

    Package.all.each do |package|
      parsed_url = \
        package.url[/(?<=github.com\/).*(?=\.git)/] || \
        package.url[/(?<=github.com\/).*/]

      unless parsed_url.present?
        non_github_packages << package
        next
      end

      user_name, repo_name = parsed_url.split '/'

      github = Github.new oauth_token: ENV['GITHUB_TOKEN']
      information = github.repos.get(user_name, repo_name).body

      if ( information.message == "Moved Permanently" )
        non_github_packages << package
        new_url = information.url

        information = HTTParty.get information["url"], \
          query: { access_token: ENV['GITHUB_TOKEN'] }
      end

      package_directory = "#{Rails.root}/#{github_directory}/#{package.name}"

      contributors_request = HTTParty.get \
        information["contributors_url"], \
        query: { access_token: ENV['GITHUB_TOKEN'] }

      contributors = JSON.parse contributors_request.body

      information['contributors_count'] = contributors.count

      FileUtils.mkdir_p(package_directory) \
        unless File.directory? package_directory

      File.open("#{github_directory}/#{package.name}/data.yml", 'w') do |h|
         h.write information.to_yaml
      end

      File.open("#{github_directory}/#{package.name}/contributors.yml", 'w') do |h|
        h.write contributors.to_yaml
      end
    end

    puts non_github_packages.map &:url
  end

  desc "unpack downloaded github information"
  task unpack: :environment do
    skipped_packages = []

    Package.all.each do |package|
      package_directory = "#{github_directory}/#{package.name}"

      unless File.directory? package_directory
        skipped_packages << package
        next
      end

      information = YAML.load_file("#{package_directory}/data.yml")

      package.repository.update url: information['html_url']

      package.update \
        description: information['description'], \
        homepage: information['homepage']

      contributors = YAML.load_file("#{package_directory}/contributors.yml")

      contributors.each do |contributor|

        user = make_or_find_entity contributor

        Contribution.create! \
          user: user, \
          package: package, \
          score: contributor['contributions']

      end

      make_counter package, information
      has_dates = make_dater package, information

      skipped_packages << package unless has_dates
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

  def make_dater package, information
    dater_hash = { package: package }

    Dater::DATE_TYPES.each do |date_type|
      date_str = information["#{date_type}_at"]
      return false unless date_str.present?

      date_time = DateTime.parse date_str
      dater_hash[date_type.to_sym] = date_time
    end

    Dater.create! dater_hash
    true
  end

  def make_or_find_entity entity
    entity_class = entity['type'].constantize
    entity_name = entity['login']

    return entity_class.friendly.find(entity_name) \
      if entity_class.friendly.exists? entity_name

    entity_object = entity_class.create! \
      name: entity_name, \
      avatar: entity['avatar_url']

    entity_object
  end

end
