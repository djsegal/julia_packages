class LogJob < ApplicationJob
  queue_as :default

  def perform(*args)
    log_files = %w[ cron delayed_job ]
    log_files << "#{ Rails.env }"

    log_files.each do |log_file|
      initial_location = "log/#{log_file}.log"
      final_location = "log/old_#{log_file}.log"

      next unless File.exist? initial_location

      FileUtils.cp(initial_location, final_location)
      File.truncate(initial_location, 0)
    end
  end

end
