namespace :job do

  desc "run boot job"
  task boot: :environment do
    BootJob.perform_now
  end

  desc "run download job"
  task download: :environment do
    DownloadJob.perform_now
  end

  desc "run expand job"
  task expand: :environment do
    ExpandJob.perform_now
  end

  desc "run update job"
  task update: :environment do
    UpdateJob.perform_now
  end

end
