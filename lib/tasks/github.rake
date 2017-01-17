namespace :github do

  @github_api_url = "https://api.github.com"

  @client_info = {
    access_token: ENV['ACCESS_TOKEN'],
    client_id: ENV['CLIENT_ID'],
    client_secret: ENV['CLIENT_SECRET']
  }

  @client_info.delete_if { |k, v| v.nil? }

  desc "download github package information"
  task download: :environment do
    bar = make_progress_bar \
      Dir.foreach(@metadata_directory).count

    nasty_count = 0
    nasty_packages = []
    moved_packages = []

    repos_directory = "#{@github_directory}/repos"

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

      is_nasty_repo = false
      information = hit_url get_repo_url(user_name, repo_name)

      if ( information["message"] == "Not Found" )
        Rails.logger.info error.message if nasty_count > 10

        fixed_repo_name = repo_name[/.*(?=\.jl)/]
        information = hit_url get_repo_url(user_name, fixed_repo_name)

        if information["message"] == "Not Found"
          nasty_packages << directory
          nasty_count += 1
          next
        end

        moved_packages << directory
      end

      if ( information.message == "Moved Permanently" )
        moved_packages << directory
        new_url = information.url

        information = hit_url information["url"]
      end

      package_directory = "#{Rails.root}/#{repos_directory}/#{directory}"

      contributors_request = hit_url information["contributors_url"]

      contributors = JSON.parse contributors_request.body

      information['contributors_count'] = contributors.count

      readme_response = hit_url "#{information['url']}/readme"

      if readme_response['encoding'] == 'base64'
        readme_work = Base64.decode64 readme_response['content']
        readme = {
          'name' => readme_response['name'],
          'content' => readme_work.force_encoding("UTF-8")
        }
      else
        nasty_packages << directory
        readme = nil
      end

      FileUtils.mkdir_p(package_directory) \
        unless File.directory? package_directory

      File.open("#{repos_directory}/#{directory}/data.yml", 'w') do |h|
         h.write information.to_yaml
      end

      File.open("#{repos_directory}/#{directory}/contributors.yml", 'w') do |h|
        h.write contributors.to_yaml
      end

      File.open("#{repos_directory}/#{directory}/readme.yml", 'w') do |h|
        h.write readme.to_yaml
      end

    end

    bar.finished

    puts "\n-------\n nasty \n-------"
    puts nasty_packages

    puts "\n-------\n moved \n-------"
    puts moved_packages

  end

  desc "expand github user information"
  task expand: :environment do
    repos_directory = "#{@github_directory}/repos"

    bar = make_progress_bar Dir.foreach("#{repos_directory}").count

    users_list = Set.new
    Dir.foreach("#{repos_directory}") do |directory|
      bar.inc
      next if directory.starts_with? '.'

      owner_login = YAML.load_file("#{repos_directory}/#{directory}/data.yml")['owner']['login']
      users_list.add owner_login

      contributors = YAML.load_file("#{repos_directory}/#{directory}/contributors.yml")
      users_list.merge contributors.map { |c| c['login'] }
    end

    bar.finished

    users_directory = "#{@github_directory}/users"

    bar = make_progress_bar users_list.count

    users_list.sort.each do |user_name|
      bar.inc

      user_directory = "#{Rails.root}/#{users_directory}/#{user_name}"
      FileUtils.mkdir_p(user_directory) \
        unless File.directory? user_directory

      information = hit_url get_user_url(user_name)
      File.open("#{users_directory}/#{user_name}/data.yml", 'w') do |h|
        h.write information.to_yaml
      end
    end

    bar.finished

    bar = make_progress_bar Dir.foreach("#{repos_directory}").count

    rotten_packages = []

    Dir.foreach("#{repos_directory}") do |directory|
      bar.inc

      next if directory.starts_with? '.'

      base_url = YAML.load_file("#{repos_directory}/#{directory}/data.yml")['url']
      commits_url = "#{base_url}/stats/participation"

      commits_info = nil
      5.times do
        commits_info = hit_url commits_url
        break unless commits_info.empty?
      end

      if commits_info.empty?
        rotten_packages << directory

        commits_info = {
          'all' => Array.new(52, 0),
          'owner' => Array.new(52, 0)
        }
      end

      File.open("#{repos_directory}/#{directory}/commits.yml", 'w') do |h|
        h.write commits_info.to_yaml
      end
    end

    bar.finished

    puts "\n-------\n rotten \n-------"
    puts rotten_packages

  end

  desc "unpack downloaded github information"
  task unpack: :environment do
    invalid_packages = []
    absent_packages = []

    users_directory = "#{@github_directory}/users"

    bar = make_progress_bar Dir.foreach("#{users_directory}").count

    Dir.foreach("#{users_directory}") do |user_name|
      bar.inc
      next if user_name.starts_with? '.'

      information = YAML.load_file("#{users_directory}/#{user_name}/data.yml")

      user_class = information['type'].constantize

      user = user_class.create! \
        name: user_name, \
        avatar: information['avatar_url']

      Profile.create! \
        owner: user,
        bio: information['bio'],
        blog: information['blog'],
        company: information['company'],
        nickname: information['name'],
        location: information['location'],
        created: information['created_at']

      Info.create! \
        owner: user,
        repos: information['public_repos'],
        gists: information['public_gists'],
        followers: information['followers'],
        following: information['following']
    end

    bar.finished

    bar = make_progress_bar Package.current_batch_scope.count

    Package.current_batch_scope.all.each do |package|
      bar.inc
      package_directory = "#{@github_directory}/repos/#{package.name}"

      unless File.directory? package_directory
        absent_packages << package
        next
      end

      information = YAML.load_file("#{package_directory}/data.yml")

      package.repository.update url: information['html_url']

      owner = make_owner package, information
      make_category package, owner

      has_good_data = make_readme package, package_directory
      has_good_data &&= make_activity package, package_directory
      has_good_data &&= make_contributors package, package_directory

      make_counter package, information
      has_good_data &&= make_dater package, information

      invalid_packages << package unless has_good_data
    end

    puts "\n-------\n absent \n-------"
    puts absent_packages.map &:name

    puts "\n-------\n invalid \n-------"
    puts invalid_packages.map &:name

    bar.finished
  end

  def hit_url url
    HTTParty.get url, query: @client_info
  end

  def get_repo_url user_name, repo_name
    url_parts = [
      @github_api_url, 'repos',
      user_name, repo_name
    ]

    url_parts.join '/'
  end

  def get_user_url user_name
    url_parts = [
      @github_api_url, 'users',
      user_name
    ]

    url_parts.join '/'
  end

  def make_owner package, information
    owner = find_entity information['owner']

    package.update \
      owner: owner, \
      homepage: information['homepage'], \
      description: information['description']

    owner
  end

  def make_category package, owner
    is_organization = \
      owner.class.name.underscore == 'organization'

    return unless is_organization
    return unless owner.name.include? 'Julia'

    category_name = owner.name.gsub 'Julia', ''

    if Category.current_batch_scope.friendly.exists? category_name
      category = Category.current_batch_scope.friendly.find(category_name)
    else
      category = Category.create! name: category_name
    end

    Label.create! \
      category: category,
      package: package
  end

  def make_readme package, package_directory
    file_name = "#{package_directory}/readme.yml"
    return false unless File.exist? file_name

    readme = YAML.load_file file_name

    return false unless readme.present?

    Readme.create! \
      package: package,
      cargo: readme['content'],
      file_name: readme['name']

    true
  end

  def make_activity package, package_directory
    file_name = "#{package_directory}/commits.yml"
    return false unless File.exist? file_name

    commits = YAML.load_file file_name

    return false unless commits.present?

    Activity.create! \
      package: package,
      commits: commits['all']

    true
  end

  def make_contributors package, package_directory
    file_name = "#{package_directory}/contributors.yml"
    return false unless File.exist? file_name

    contributors = YAML.load_file file_name

    contributors.each do |contributor|
      user = find_entity contributor

      Contribution.create! \
        user: user, \
        package: package, \
        score: contributor['contributions']
    end

    true
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

  def find_entity entity
    entity_class = entity['type'].constantize
    entity_name = entity['login']

    entity_class.current_batch_scope.friendly.find(entity_name)
  end

end
