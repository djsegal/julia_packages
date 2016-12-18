@metadata_directory = 'tmp/METADATA.jl'
@github_directory = 'tmp/github'

def clean_field_list field_list
  cleaned_list = field_list.deep_dup
  cleaned_list.reject! { |field| field == 'id' }
  cleaned_list.reject! { |field| field.ends_with? '_id' }
  cleaned_list.reject! { |field| field.ends_with? '_at' }
  cleaned_list
end
