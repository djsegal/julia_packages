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

end
