puts "\nDependencies"

dependency_list = []

work_packages = @general_db["package"].to_a

work_shallow_depending_list = @general_db["shallow_depending"].to_a
work_deep_depending_list = @general_db["deep_depending"].to_a

work_shallow_dependents_list = @general_db["shallow_dependents"].to_a
work_deep_dependents_list = @general_db["deep_dependents"].to_a

@all_packages.each_with_progress do |cur_package|
  cur_index = work_packages.index cur_package.name
  next if cur_index.nil?

  work_shallow_depending = @all_packages.select{ |work_package| work_shallow_depending_list[cur_index].include? work_package.name }
  work_deep_depending = @all_packages.select{ |work_package| work_deep_depending_list[cur_index].include? work_package.name }

  depending_dict = {
    true => work_shallow_depending,
    false => work_deep_depending,
  }

  depending_dict.each do |tmp_shallow, tmp_depending|
    tmp_depending.each do |tmp_dependee|
      dependency_list << Dependency.new(
        depender: cur_package,
        dependee: tmp_dependee,
        shallow: tmp_shallow
      )
    end
  end

  if dependency_list.length >= 512
    Dependency.import dependency_list
    dependency_list = []
  end
end

Dependency.import dependency_list

puts ""
