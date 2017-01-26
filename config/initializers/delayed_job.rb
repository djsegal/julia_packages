if Rails.env.production?

  log_file = \
    File.join Rails.root, 'log', 'delayed_job.log'

  Delayed::Worker.logger = \
    Logger.new log_file

  if caller.last =~ /script\/delayed_job/ or (File.basename($0) == "rake" and ARGV[0] =~ /jobs\:work/)
    ActiveRecord::Base.logger = Delayed::Worker.logger
  end

  ActionMailer::Base.logger = Delayed::Worker.logger

end
