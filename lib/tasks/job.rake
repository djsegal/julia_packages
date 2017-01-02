namespace :job do

  desc "run julia job"
  task julia: :environment do
    JuliaJob.perform_now
  end

end
