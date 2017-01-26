class ScourJob < ApplicationJob
  queue_as :default

  def perform(*args)
    FileUtils.rm_rf "tmp/scour"

    system "#{@sys_run} github:scour"
  end
end
