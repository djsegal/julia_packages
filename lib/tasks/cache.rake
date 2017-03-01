namespace :cache do

  desc "flush github expanded information"
  task flush: :environment do
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

      Rails.cache.delete(get_user_url(user_name))
    end

    bar.finished

    bar = make_progress_bar Dir.foreach("#{repos_directory}").count

    Dir.foreach("#{repos_directory}") do |directory|
      bar.inc

      next if directory.starts_with? '.'

      base_url = YAML.load_file("#{repos_directory}/#{directory}/data.yml")['url']
      commits_url = "#{base_url}/stats/participation"

      Rails.cache.delete(commits_url)
    end

    bar.finished

  end

end
