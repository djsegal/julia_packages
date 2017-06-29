namespace :metadata do

  desc "clone metadata project"
  task clone: :environment do
    system_command = "git clone https://github.com/JuliaLang/METADATA.jl.git ./#{@metadata_directory}"
    did_clone = system system_command
    throw 'Clone metadata task failed.' unless did_clone
  end

  desc "update local metadata project"
  task pull: :environment do
    system_command = "git -C #{@metadata_directory} pull"
    did_pull = system system_command
    throw 'Pull metadata task failed.' unless did_pull
  end

  desc "reset local metadata project"
  task reset: :environment do
    system_command = "git -C #{@metadata_directory} fetch --all"
    did_reset = system system_command
    system_command = "git -C #{@metadata_directory} reset origin --hard"
    did_reset = system system_command

    throw 'Reset metadata task failed.' unless did_reset
  end

  desc "digest metadata into database"
  task digest: :environment do
    bar = make_progress_bar Dir["#{@metadata_directory}/*"].count
    non_versioned_packages = []

    new_packages = []

    Dir.foreach(@metadata_directory) do |directory|
      bar.inc

      next if directory.starts_with? '.'
      next if File.file? \
        "#{@metadata_directory}/#{directory}"

      package = Package.new name: directory

      make_metadata_repository package
      has_versions = make_versions package

      new_packages << package
      non_versioned_packages << package unless has_versions
    end

    new_packages.each do |cur_package|
      cur_package.versions.each do |cur_version|
        cur_version.run_callbacks(:save) { false }
      end
    end

    Package.import new_packages, recursive: true

    new_batches = []

    cur_marker = Batch.current_marker

    new_packages.each do |cur_package|
      new_batches << Batch.new(
        item: cur_package,
        marker: cur_marker
      )
    end

    Batch.import(new_batches)

    puts non_versioned_packages.map &:url
    bar.finished
  end

  def make_metadata_repository package
    url_file = "#{@metadata_directory}/#{package.name}/url"
    url = File.open(url_file).read.strip

    repository = package.build_repository url: url
  end

  def make_versions package
    vesions_directory = "#{@metadata_directory}/#{package.name}/versions"
    return false unless File.directory? vesions_directory

    Dir.foreach(vesions_directory) do |directory|
      next if directory.starts_with? '.'

      raise "Invalid version number for: #{package.name} - #{directory}" \
        unless directory.match /\d+\.\d+\.\d+/

      sha1 = nil
      Dir.foreach("#{vesions_directory}/#{directory}") do |file|
        next if file.starts_with? '.'
        next if file == 'requires'

        if file == 'sha1'
          sha1_file = "#{@metadata_directory}/#{package.name}/versions/#{directory}/sha1"
          sha1 = File.open(sha1_file).read.strip
          next
        end

        raise "Invalid file name for: #{package.name} - #{file}"
      end

      version = package.versions.build number: directory, sha1: sha1
    end

    true
  end

end
