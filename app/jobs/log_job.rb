class LogJob < ApplicationJob
  queue_as :default

  def perform(*args)
    initial_location = "log/cron.log"
    final_location = "log/old_cron.log"
    FileUtils.mv initial_location, final_location
  end

end
