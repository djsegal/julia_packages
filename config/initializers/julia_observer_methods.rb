def clean_field_list field_list
  cleaned_list = field_list.deep_dup
  cleaned_list.reject! { |field| field == 'id' }
  cleaned_list.reject! { |field| field.ends_with? '_id' }
  cleaned_list.reject! { |field| field.ends_with? '_at' }
  cleaned_list.reject! { |field| field.ends_with? '_type' }
  cleaned_list
end

def get_initial_batch_marker marker_type, default_value
  batch_directory = 'tmp/batch'
  file_name = "#{marker_type}.yml"
  file_path = "#{batch_directory}/#{file_name}"

  return YAML.load_file(file_path) \
    if File.exist? file_path

  FileUtils.mkdir_p(batch_directory) \
    unless File.directory? batch_directory

  File.open(file_path, 'w') do |h|
    h.puts default_value.to_yaml
  end

  default_value
end

def set_batch_marker marker_type, new_value
  batch_directory = 'tmp/batch'
  file_name = "#{marker_type}.yml"
  file_path = "#{batch_directory}/#{file_name}"

  File.open(file_path, 'w') do |h|
    h.puts new_value.to_yaml
  end
end

def tail(path, n)
  file = File.open(path, "r")
  buffer_s = 512
  line_count = 0
  file.seek(0, IO::SEEK_END)

  offset = file.pos # we start at the end

  while line_count <= n && offset > 0
    to_read = if (offset - buffer_s) < 0
                offset
              else
                buffer_s
              end

    file.seek(offset-to_read)
    data = file.read(to_read)

    data.reverse.each_char do |c|
      if line_count > n
        offset += 1
        break
      end
      offset -= 1
      if c == "\n"
        line_count += 1
      end
    end
  end

  file.seek(offset)
  data = file.readlines

  data.map! { |line|
    next line unless line.include? "\e"
    line.gsub! "\e", "]"
    line.sub! "]", "\e"

    line.reverse!
    line.sub! "\n", "]"
    line.reverse!
  }

  file.close
  data
end
