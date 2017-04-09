namespace :require do

  desc "setup all dependencies"
  task all: :environment do
    Rake::Task["require:shallow"].invoke
    Rake::Task["require:deep"].invoke
  end

  desc "setup shallow dependencies"
  task shallow: :environment do
    ghost_packages = Set.new

    bar = make_progress_bar Package.current_batch_scope.count

    Package.current_batch_scope.all.each do |package|
      bar.inc

      Dependency.where(dependent: package).destroy_all

      package_directory = "#{@github_directory}/repos/#{package.name}"

      file_name = "#{package_directory}/REQUIRE.yml"
      next unless File.exist? file_name

      require_file = YAML.load_file file_name
      next unless require_file.present?
      require_file = require_file['content']

      depended_packages = require_file.split("\n").reject &:blank?

      depended_packages.each do |depended_package_line|
        depended_name = depended_package_line.split.first

        next if depended_name.starts_with? '#'
        next if depended_name.starts_with? '@'

        unless Package.current_batch_scope.friendly.exists? depended_name
          ghost_packages.add depended_name
          next
        end

        depended_package = \
          Package.current_batch_scope.friendly.find depended_name

        Dependency.create! \
          is_shallow: true,
          dependent: package,
          depended: depended_package
      end
    end

    bar.finished

    puts ghost_packages.to_a.inspect
  end

  desc "setup deep dependencies"
  task deep: :environment do
    added_something_this_round = true

    while added_something_this_round
      added_something_this_round = false

      Package.current_batch_scope.all.each do |package|
        package.depending.each do |depended_package|
          deep_dependencies = depended_package.depending - package.depending
          next if deep_dependencies.empty?

          added_something_this_round = true
          deep_dependencies.each do |deep_dependency|
            Dependency.create! \
              is_shallow: false,
              dependent: package,
              depended: deep_dependency

            package.reload
          end
        end
      end
    end
  end

end
