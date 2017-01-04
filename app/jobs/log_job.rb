class LogJob < ApplicationJob
  queue_as :default

  def perform(*args)
    FileUtils.rm "log/cron.log", force: true
  end

end
