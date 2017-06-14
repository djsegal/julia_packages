class CrawlJob < ApplicationJob
  queue_as :default

  def perform(*args)
    system "#{@sys_run} crawl:github"
  end

end
