namespace :job do

  desc "run boot job"
  task boot: :environment do
    puts "\nrunning boot job @ #{DateTime.now.localtime}\n"
    BootJob.perform_now
  end

  desc "run download job"
  task download: :environment do
    puts "\nrunning download job @ #{DateTime.now.localtime}\n"
    DownloadJob.perform_now
  end

  desc "run expand job"
  task expand: :environment do
    puts "\nrunning expand job @ #{DateTime.now.localtime}\n"
    ExpandJob.perform_now
  end

  desc "run update job"
  task update: :environment do
    puts "\nrunning update job @ #{DateTime.now.localtime}\n"
    UpdateJob.perform_now
  end

  desc "run log job"
  task log: :environment do
    puts "\nrunning log job @ #{DateTime.now.localtime}\n"
    LogJob.perform_now
  end

  desc "run clean job"
  task clean: :environment do
    puts "\nrunning clean job @ #{DateTime.now.localtime}\n"
    CleanJob.perform_now
  end

end
