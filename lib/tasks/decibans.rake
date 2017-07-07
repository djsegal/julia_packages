namespace :decibans do

  desc "clone decibans project"
  task clone: :environment do
    system_command = "git clone https://github.com/svaksha/Julia.jl.git ./#{@decibans_directory}"
    did_clone = system system_command
    throw 'Clone decibans task failed.' unless did_clone
  end

  desc "update local decibans project"
  task pull: :environment do
    system_command = "git -C #{@decibans_directory} pull"
    did_pull = system system_command
    throw 'Pull decibans task failed.' unless did_pull
  end

  desc "reset local decibans project"
  task reset: :environment do
    system_command = "git -C #{@decibans_directory} fetch --all"
    did_reset = system system_command
    system_command = "git -C #{@decibans_directory} reset origin --hard"
    did_reset = system system_command

    throw 'Reset decibans task failed.' unless did_reset
  end

  desc "digest decibans into database"
  task digest: :environment do
    deciban_dict = {}

    misaligned_decibans = []
    missing_decibans = []
    duplicated_decibans = []

    bar = make_progress_bar Dir["#{@decibans_directory}/*"].count

    Dir.foreach(@decibans_directory) do |deciban|
      next if deciban.starts_with? '.'
      bar.inc

      next unless File.file? \
        "#{@decibans_directory}/#{deciban}"

      next unless deciban.ends_with? '.md'
      deciban.gsub! ".md", ""

      skipped_files = %w[ README LICENSE Publications ]
      next if skipped_files.include? deciban

      deciban_file = "#{@decibans_directory}/#{deciban}.md"

      deciban_list = []

      has_complete_list = false

      current_deciban = nil

      File.open(deciban_file).each_line do |deciban_line|
        unless has_complete_list
          has_complete_list ||= deciban_line.starts_with? "----"
          next unless deciban_line =~ /^[\*\+\-]\s(?=\[)/
          deciban_list << deciban_line.match(/(?<=\[).*(?=\])/)[0]
          next
        end

        is_header = deciban_line =~ /#\s.*/
        is_header &&= deciban_list.include? deciban_line.match(/(?<=#\s).*(?=\n)/)[0]

        if is_header
          current_deciban = deciban_line.match(/(?<=#\s).*(?=\n)/)[0]

          deciban_dict[current_deciban] = [] \
            unless deciban_dict.key? current_deciban

          next
        end

        matched_package = deciban_line.match /(?<=\[)[^\.]+(?=\.jl\])/
        next unless matched_package.present?

        begin
          deciban_dict[current_deciban] << matched_package[0]
        rescue
          misaligned_decibans << matched_package[0]
        end
      end

    end

    bar.finished

    empty_decibans = deciban_dict.keys
    deciban_dict.delete_if { |k, v| v.empty? }
    empty_decibans -= deciban_dict.keys

    bar = make_progress_bar deciban_dict.length

    new_labels = []

    deciban_dict.each do |cur_key, cur_value|
      bar.inc

      category = Category.create! name: cur_key.titleize

      cur_value.each do |package_name|
        unless Package.custom_exists? package_name, batch_scope: "current_batch_scope"
          missing_decibans << package_name
          next
        end

        package = Package.custom_find package_name, batch_scope: "current_batch_scope"

        is_duplicated_package = new_labels.any? {
          |cur_label| cur_label.category == category && cur_label.package == package
        }

        if is_duplicated_package
          duplicated_decibans << package.name
          next
        end

        new_labels << Label.new(
          category: category,
          package: package
        )
      end
    end

    Label.import new_labels

    bar.finished

    puts "\n-------\n misaligned \n-------"
    puts misaligned_decibans

    puts "\n-------\n duplicated \n-------"
    puts duplicated_decibans

    puts "\n-------\n missing \n-------"
    puts missing_decibans

    puts "\n-------\n empty \n-------"
    puts empty_decibans

  end

end
