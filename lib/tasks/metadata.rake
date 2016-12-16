namespace :metadata do

  metadata_directory = 'tmp/METADATA.jl'

  desc "clone metadata project"
  task clone: :environment do
    `git clone https://github.com/JuliaLang/METADATA.jl.git ./#{metadata_directory}`
  end

  desc "update local metadata project"
  task pull: :environment do
    `git -C #{metadata_directory} pull`
  end

  desc "digest metadata into database"
  task digest: :environment do
    Dir.foreach(metadata_directory) do |directory|
      next if directory.starts_with? '.'
      next if File.file? \
        "#{metadata_directory}/#{directory}"

      package = Package.create! name: directory

      url_file = "#{metadata_directory}/#{directory}/url"
      url = File.open(url_file).read.strip

      repository = Repository.create! url: url, package: package
    end
  end

  desc "expand package information with github"
  task github: :environment do
    Package.all.each do |package|
      parsed_url = package.url[/(?<=github.com\/).*(?=.git)/]
      raise "Non-github repository url detected:
        #{package.url}" unless parsed_url.present?

      user_name, repo_name = parsed_url.split '/'

      github = Github.new
      github.repos.get user_name, repo_name
    end
  end

end
