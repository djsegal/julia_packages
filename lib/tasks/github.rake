namespace :github do

  desc "download github package information"
  task download: :environment do
    bar = RakeProgressbar.new \
      Dir.foreach(@metadata_directory).count

    nasty_packages = []
    moved_packages = []

    Dir.foreach(@metadata_directory) do |directory|

      bar.inc

      next if directory.starts_with? '.'
      next if File.file? \
        "#{@metadata_directory}/#{directory}"

      url_file = "#{@metadata_directory}/#{directory}/url"
      url = File.open(url_file).read.strip

      parsed_url = \
        url[/(?<=github.com\/).*(?=\.git)/] || \
        url[/(?<=github.com\/).*/]

      unless parsed_url.present?
        moved_packages << directory
        next
      end

      user_name, repo_name = parsed_url.split '/'

      github = Github.new oauth_token: ENV['GITHUB_TOKEN']

      is_nasty_repo = false
      begin
        information = github.repos.get(user_name, repo_name).body
      rescue
        begin
          fixed_repo_name = repo_name[/.*(?=\.jl)/]
          information = github.repos.get(user_name, fixed_repo_name).body
          moved_packages << directory
        rescue
          nasty_packages << directory
          is_nasty_repo = true
        end
      end
      next if is_nasty_repo

      if ( information.message == "Moved Permanently" )
        moved_packages << directory
        new_url = information.url

        information = HTTParty.get information["url"], \
          query: { access_token: ENV['GITHUB_TOKEN'] }
      end

      package_directory = "#{Rails.root}/#{@github_directory}/#{directory}"

      contributors_request = HTTParty.get \
        information["contributors_url"], \
        query: { access_token: ENV['GITHUB_TOKEN'] }

      contributors = JSON.parse contributors_request.body

      information['contributors_count'] = contributors.count

      readme_response = HTTParty.get "#{information['url']}/readme", \
        query: { access_token: ENV['GITHUB_TOKEN'] }

      if readme_response['encoding'] == 'base64'
        readme_work = Base64.decode64 readme_response['content']
        readme = {
          name: readme_response['name'],
          content: readme_work.force_encoding("UTF-8")
        }
      else
        nasty_packages << directory
        readme = nil
      end

      FileUtils.mkdir_p(package_directory) \
        unless File.directory? package_directory

      File.open("#{@github_directory}/#{directory}/data.yml", 'w') do |h|
         h.write information.to_yaml
      end

      File.open("#{@github_directory}/#{directory}/contributors.yml", 'w') do |h|
        h.write contributors.to_yaml
      end

      File.open("#{@github_directory}/#{directory}/readme.yml", 'w') do |h|
        h.write readme.to_yaml
      end

    end

    puts "\n-------\n nasty \n-------"
    puts nasty_packages

    puts "\n-------\n moved \n-------"
    puts moved_packages

    bar.finished
  end

  desc "unpack downloaded github information"
  task unpack: :environment do
    bar = RakeProgressbar.new Package.count
    skipped_packages = []

    Package.all.each do |package|
      bar.inc
      package_directory = "#{@github_directory}/#{package.name}"

      unless File.directory? package_directory
        skipped_packages << package
        next
      end

      information = YAML.load_file("#{package_directory}/data.yml")

      package.repository.update url: information['html_url']

      owner = make_or_find_entity information['owner']

      package.update \
        owner: owner, \
        homepage: information['homepage'], \
        description: information['description']

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
    bar.finished
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
