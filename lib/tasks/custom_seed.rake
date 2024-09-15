namespace :custom_seed do
  desc "TODO"
  task readmes: :environment do
    ENV['SEED_TARGET'] = 'readmes'

    raise 'Custom Error: Has no Packages.' if Package.count == 0
    raise 'Custom Error: Already has Readmes.' if Readme.count > 0
    
    Rake::Task['db:seed'].invoke    
  end
end
