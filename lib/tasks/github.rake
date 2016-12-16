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
  end

end
