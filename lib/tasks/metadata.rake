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

end
