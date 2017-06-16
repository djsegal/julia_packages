namespace :github do

  desc "download github package information"
  task download: :environment do
    all_packages = Dir.foreach(@scour_directory).to_a
    all_packages += Dir.foreach(@metadata_directory).to_a

    all_packages.uniq!
    all_packages.sort!

    bar = make_progress_bar all_packages.count

    nasty_count = 0
    nasty_packages = []
    moved_packages = []

    repos_directory = "#{@github_directory}/repos"

    all_packages.each do |directory|

      bar.inc

      next if directory.starts_with? '.'
      next if File.file? \
        "#{@metadata_directory}/#{directory}"

      is_from_metadata = \
        File.directory? "#{@metadata_directory}/#{directory}"

      is_scoured_package = ( not is_from_metadata )

      is_scoured_package &&= \
        File.directory? "#{@scour_directory}/#{directory}"

      if is_scoured_package

        information = \
          YAML.load_file("#{@scour_directory}/#{directory}/data.yml")

        touched_date = information.select{
          |i| ['updated_at','pushed_at'].include? i
        }.values.map{ |v| v.to_date }.max

        is_new_response = \
          touched_date > 1.day.ago

      else

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
        information, is_new_response = \
          check_and_hit_url get_repo_url(user_name, repo_name)

        if ( information["message"] == "Not Found" )
          Rails.logger.info error.message if nasty_count > 10

          fixed_repo_name = repo_name[/.*(?=\.jl)/]
          information, is_new_response = \
            check_and_hit_url get_repo_url(user_name, fixed_repo_name)

          if information["message"] == "Not Found"
            nasty_packages << directory
            nasty_count += 1
            next
          end

          moved_packages << directory
        end

        if ( information["message"] == "Moved Permanently" )
          moved_packages << directory
          new_url = information["url"]

          information, is_new_response = \
            check_and_hit_url information["url"]
        end

      end

      package_directory = "#{Rails.root}/#{repos_directory}/#{directory}"

      information['is_scoured_package'] = is_scoured_package

      contributors_request = hit_url information["contributors_url"], is_new_response

      if contributors_request.is_a? Array
        contributors = contributors_request
      elsif contributors_request.is_a? Hash
        nasty_packages << directory
        contributors = []
      else
        contributors = JSON.parse contributors_request.body
      end

      information['contributors_count'] = contributors.count

      readme_response = hit_url "#{information['url']}/readme", is_new_response

      if readme_response['encoding'] == 'base64'
        readme_work = Base64.decode64 readme_response['content']
        readme = {
          'name' => readme_response['name'],
          'content' => readme_work.force_encoding("UTF-8")
        }
      else
        nasty_packages << directory
        readme = {
          'name' => 'README.md',
          'content' => ''
        }
      end

      require_response = hit_url "#{information['url']}/contents/REQUIRE", is_new_response

      require_file = {
        'name' => 'REQUIRE',
        'content' => ''
      }

      if require_response['encoding'] == 'base64'
        require_file['content'] = \
          Base64.decode64 require_response['content']
      else
        nasty_packages << directory
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

      File.open("#{repos_directory}/#{directory}/require.yml", 'w') do |h|
        h.write require_file.to_yaml
      end

    end

    bar.finished

    puts "\n-------\n nasty \n-------"
    puts nasty_packages.uniq.sort

    puts "\n-------\n moved \n-------"
    puts moved_packages.uniq.sort

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

      information = hit_url get_user_url(user_name), false, get_expiry
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

      5.times do |i|
        unless i.zero?
          sleep 1
          Rails.cache.delete(commits_url)
        end

        commits_info = hit_url commits_url, false, get_expiry
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
    puts rotten_packages.uniq.sort

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

      unless information['type'].present?
        CronLogMailer.log_email(
          "Unpack I", information.to_yaml
        ).deliver_now

        next
      end

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

      package.update is_registered: !information['is_scoured_package']
      package.repository.update url: information['html_url']

      owner = make_owner package, information
      has_good_data = owner.present?

      make_category package, owner

      has_good_data &&= make_readme package, package_directory
      has_good_data &&= make_activity package, package_directory
      has_good_data &&= make_contributors package, package_directory

      make_counter package, information
      has_good_data &&= make_dater package, information

      invalid_packages << package unless has_good_data
    end

    puts "\n-------\n absent \n-------"
    puts absent_packages.map(&:name).uniq.sort

    puts "\n-------\n invalid \n-------"
    puts invalid_packages.map(&:name).uniq.sort

    bar.finished
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

    if Category.custom_exists? category_name, batch_scope: "current_batch_scope"
      category = Category.custom_find category_name, batch_scope: "current_batch_scope"
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

    package.update \
      readme: readme['content'],
      readme_type: readme['name']

    true
  end

  def make_activity package, package_directory
    file_name = "#{package_directory}/commits.yml"
    return false unless File.exist? file_name

    commits = YAML.load_file file_name

    return false unless commits.present?

    begin
      Activity.create! \
        package: package,
        commits: commits['all']
    rescue
      DebugLogMailer.log_email(
        "Bad Activity", "#{package.name} => #{commits.inspect}".to_yaml
      ).deliver_later

      return false
    end

    true
  end

  def make_contributors package, package_directory
    file_name = "#{package_directory}/contributors.yml"
    return false unless File.exist? file_name

    contributors = YAML.load_file file_name

    contributors.each do |contributor|
      user = find_entity contributor
      next unless user.present?

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

    unless entity_class.custom_exists? entity_name, batch_scope: "current_batch_scope"
      CronLogMailer.log_email(
        "Unpack II", entity.to_yaml
      ).deliver_now

      return
    end

    entity_class.custom_find entity_name, batch_scope: "current_batch_scope"
  end

  def get_expiry
    tomorrow = 1.day.from_now
    next_week = 1.week.from_now

    today = Time.now
    end_day = rand tomorrow..next_week

    day_count = TimeDifference.between(today, end_day).in_days
    day_count.days
  end

end
