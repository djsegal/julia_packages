class LogJob < ApplicationJob
  queue_as :default

  def perform(*args)
    log_files = %w[ cron delayed_job ]
    log_files << "#{ Rails.env }"

    log_files.each do |log_file|
      initial_location = "log/#{log_file}.log"
      final_location = "log/old_#{log_file}.log"

      FileUtils.mv(initial_location, final_location) \
        if File.exist? initial_location

      FileUtils.touch initial_location
      FileUtils.chmod 755, initial_location
    end
  end

end
