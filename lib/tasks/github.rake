namespace :github do

  desc "download github package information"
  task download: :environment do
    all_packages = Dir.foreach(@scour_directory).to_a
    all_packages += Dir.foreach(@metadata_directory).to_a

    all_packages.uniq!
    all_packages.sort!

    bar = make_progress_bar all_packages.count

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
          fixed_repo_name = repo_name[/.*(?=\.jl)/]
          information, is_new_response = \
            check_and_hit_url get_repo_url(user_name, fixed_repo_name)

          if information["message"] == "Not Found"
            nasty_packages << directory
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

      unless information["contributors_url"].present?
        nasty_packages << directory

        information['bad_egg'] = directory

        CronLogMailer.log_email(
          "Contributors URL", information.to_yaml
        ).deliver_now

        next
      end

      contributors_request = hit_url information["contributors_url"], is_new_response

      if contributors_request.is_a? Array
        contributors = contributors_request
      elsif contributors_request.is_a? Hash
        nasty_packages << directory
        contributors = []
      elsif contributors_request.is_a? String
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

    puts "\n-------\n done. \n"

  end

  desc "expand github user information"
  task expand: :environment do
    repos_directory = "#{@github_directory}/repos"

    bar = make_progress_bar Dir.foreach("#{repos_directory}").count

    users_list = Set.new
    Dir.foreach("#{repos_directory}") do |directory|
      next if directory.starts_with? '.'
      bar.inc

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

      begin
        information = hit_url get_user_url(user_name), false, get_expiry
      rescue
        information = {}

        CronLogMailer.log_email(
          "Expand", get_user_url(user_name).to_yaml
        ).deliver_now
      end

      File.open("#{users_directory}/#{user_name}/data.yml", 'w') do |h|
        h.write information.to_yaml
      end
    end

    bar.finished

    bar = make_progress_bar Dir.foreach("#{repos_directory}").count

    rotten_packages = []

    Dir.foreach("#{repos_directory}") do |directory|
      next if directory.starts_with? '.'
      bar.inc

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

    new_bots = []
    new_users = []
    new_organizations = []

    Dir.foreach("#{users_directory}") do |user_name|
      next if user_name.starts_with? '.'
      bar.inc

      user_file = "#{users_directory}/#{user_name}/data.yml"

      if File.exist? user_file
        information = YAML.load_file(user_file)
      else
        information = { bad_user: user_file }
      end

      unless information['type'].present?
        CronLogMailer.log_email(
          "Unpack I", information.to_yaml
        ).deliver_now

        next
      end

      begin
        user_class = information['type'].constantize
      rescue
        puts ["bad type",information['type'],information]
        next
      end

      user = user_class.new \
        name: user_name, \
        avatar: information['avatar_url']

      user.build_profile \
        bio: information['bio'],
        blog: information['blog'],
        company: information['company'],
        nickname: information['name'],
        location: information['location'],
        created: information['created_at']

      user.build_info \
        repos: information['public_repos'],
        gists: information['public_gists'],
        followers: information['followers'],
        following: information['following']

      if information['type'] == "User"
        new_users << user
      elsif information['type'] == "Organization"
        new_organizations << user
      elsif information['type'] == "Bot"
        new_bots << user
      else
        CronLogMailer.log_email(
          "Unpack III", information.to_yaml
        ).deliver_now
      end
    end

    Bot.import new_bots, recursive: true
    User.import new_users, recursive: true
    Organization.import new_organizations, recursive: true

    new_batches = []

    cur_marker = Batch.current_marker

    cur_entities = new_users
    cur_entities += new_organizations
    cur_entities += new_bots

    cur_entities.each do |cur_entity|
      new_batches << Batch.new(
        item: cur_entity,
        marker: cur_marker
      )
    end

    Batch.import(new_batches)

    bar.finished

    bar = make_progress_bar Package.current_batch_scope.count

    new_activities = []
    new_contributions = []
    new_counters = []
    new_daters = []

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

      has_good_data &&= make_readme package, package_directory

      if has_good_data
        cur_activity = make_activity package, package_directory
        cur_contributions = make_contributors package, package_directory

        has_good_data &&= cur_activity.present?
        has_good_data &&= cur_contributions.present?
      end

      if has_good_data
        cur_counter = make_counter package, information
        cur_dater = make_dater package, information

        has_good_data &&= cur_counter.present?
        has_good_data &&= cur_dater.present?
      end

      if has_good_data
        new_activities << cur_activity
        new_contributions += cur_contributions
        new_counters << cur_counter
        new_daters << cur_dater
      else
        invalid_packages << package
      end
    end

    ( new_activities + new_daters ).each do |cur_thing|
      cur_thing.run_callbacks(:save) { false }
    end

    Activity.import new_activities
    Contribution.import new_contributions
    Counter.import new_counters
    Dater.import new_daters

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

  def make_readme package, package_directory
    file_name = "#{package_directory}/readme.yml"
    return false unless File.exist? file_name

    readme = YAML.load_file file_name

    return false unless readme.present?

    readme.each{ |_, str| str.gsub! "\u0000", "" }

    package.update \
      readme: readme['content'],
      readme_type: readme['name']

    true
  end

  def make_activity package, package_directory
    file_name = "#{package_directory}/commits.yml"

    is_bad_activity = !File.exist?(file_name)

    commits = { bad_commits: ":(" }

    unless is_bad_activity
      commits = YAML.load_file file_name

      is_bad_activity = !commits.present?
    end

    bad_commit_messages = [
      "Not Found",
      "Server Error"
    ]

    is_bad_activity ||= \
      bad_commit_messages.include? commits['message']

    unless is_bad_activity
      begin
        cur_activity = Activity.new \
          package: package,
          commits: commits['all']
      rescue
        is_bad_activity = true
      end
    end

    if is_bad_activity
      mail_param_list = [
        "Bad Activity", "#{package.name} => #{commits.inspect}".to_yaml
      ]

      if Rails.env.production?
        DebugLogMailer.log_email(*mail_param_list).deliver_later
      else
        DebugLogMailer.log_email(*mail_param_list).deliver_now
      end

      return nil
    end

    cur_activity
  end

  def make_contributors package, package_directory
    file_name = "#{package_directory}/contributors.yml"
    return nil unless File.exist? file_name

    contributors = YAML.load_file file_name

    cur_contributions = []

    contributors.each do |contributor|
      user = find_entity contributor
      next unless user.present?

      cur_contributions << Contribution.new(
        user: user, \
        package: package, \
        score: contributor['contributions']
      )
    end

    cur_contributions
  end

  def make_counter package, information
    columns = clean_field_list Counter.column_names

    counter_hash = { package: package }
    columns.each do |column|
      counter_hash[column.to_sym] = information["#{column.pluralize}_count"]
    end

    Counter.new counter_hash
  end

  def make_dater package, information
    dater_hash = { package: package }

    Dater::DATE_TYPES.each do |date_type|
      date_str = information["#{date_type}_at"]
      return nil unless date_str.present?

      date_time = DateTime.parse date_str
      dater_hash[date_type.to_sym] = date_time
    end

    Dater.new dater_hash
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
