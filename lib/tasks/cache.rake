namespace :cache do

  @cached_types = %w[ users repos ]

  desc "flush all github expanded information"
  task flush_all: :environment do
    @cached_types.each do |cached_type|
      Rake::Task["cache:flush_#{cached_type}"].invoke
    end
  end

  desc "flush users info"
  task flush_users: :environment do
    cache_deleted = 0

    users_directory = "#{@github_directory}/users"

    bar = make_progress_bar Dir.foreach("#{users_directory}").count

    Dir.foreach("#{users_directory}") do |user_name|
      bar.inc

      cache_deleted += 1 \
        if Rails.cache.delete(get_user_url(user_name))
    end

    bar.finished

    puts "\nUsers Cache deleted: #{ cache_deleted }\n"
  end

  desc "flush repo activity"
  task flush_repos: :environment do
    cache_deleted = 0

    repos_directory = "#{@github_directory}/repos"

    bar = make_progress_bar Dir.foreach("#{repos_directory}").count

    Dir.foreach("#{repos_directory}") do |directory|
      bar.inc

      next if directory.starts_with? '.'

      base_url = YAML.load_file("#{repos_directory}/#{directory}/data.yml")['url']
      commits_url = "#{base_url}/stats/participation"

      cache_deleted += 1 \
        if Rails.cache.delete(commits_url)
    end

    bar.finished

    puts "\nRepos Cache deleted: #{ cache_deleted }\n"
  end

end
