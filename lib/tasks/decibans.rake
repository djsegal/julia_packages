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

    missing_decibans = []
    duplicated_decibans = []

    cur_file = File.read("#{@decibans_directory}/db.csv")

    cur_file.prepend(
      "category,subcategory,name,url,description\n"
    )

    cur_csv = CSV.parse(cur_file, headers: true)

    cur_table = cur_csv.map &:to_hash

    category_list = cur_table.map{ |cur_obj| cur_obj["category"] }.uniq

    category_list.each do |cur_category|
      subcategory_list = cur_table
        .select{ |cur_obj| cur_obj["category"] == cur_category }
        .map{ |cur_obj| cur_obj["subcategory"] }
        .each_with_object(Hash.new(0)){ |key,hash| hash[key] += 1 }

      subcategory_list.each do |cur_subcategory, cur_count|
        cur_rows = cur_table.select { |cur_obj|
          cur_obj["subcategory"] == cur_subcategory &&
          cur_obj["name"].ends_with?(".jl") &&
          !cur_obj["name"].include?(" ")
        }

        cur_packages = cur_rows.map {
          |cur_obj| cur_obj["name"].gsub(".jl", "")
        }

        if cur_subcategory.present? && cur_count > 15
          deciban_dict[cur_subcategory] = cur_packages
          next
        end

        deciban_dict[cur_category] = [] \
          unless deciban_dict.has_key? cur_category

        deciban_dict[cur_category] += cur_packages
      end
    end

    bar = make_progress_bar deciban_dict.length

    new_labels = []

    mapped_names = {
      "MACHINELEARNING" => "Machine Learning",
      "NEURALNETWORKS" => "Neural Networks",
      "INFOGRAPHICS" => "Infographics",
      "UNITTEST" => "Unit Tests",
      "JUPYTERNOTEBOOKS" => "Jupyter Notebooks",
    }

    deciban_dict.each do |cur_key, cur_value|
      bar.inc

      cur_name = cur_key

      cur_name = cur_name[/(?<=\[).*(?=\])/] \
        if cur_name.include? "["

      cur_name = cur_name[/.*(?=\()/] \
        if cur_name.include? "("

      if cur_name.upcase == cur_name
        downcased_name = cur_name.downcase
        File.open("vendor/words.txt", "r").each_line do |line|
          next unless line.strip == downcased_name

          cur_name = cur_name.underscore.humanize.titleize
          break
        end
      else
        cur_name = cur_name.underscore.humanize.titleize \
          unless cur_name =~ /\d/
      end

      cur_name = mapped_names[cur_name] \
        if mapped_names.keys.include? cur_name

      category = Category.create! name: cur_name

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

    puts "\n-------\n duplicated \n-------"
    puts duplicated_decibans

    puts "\n-------\n missing \n-------"
    puts missing_decibans

  end

end
