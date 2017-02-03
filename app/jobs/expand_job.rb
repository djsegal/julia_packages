class ExpandJob < JuliaJob
  queue_as :default

  def perform(*args)
    system "#{@sys_run} github:expand"

    FileUtils.rm_rf "tmp/news"
    system "#{@sys_run} news:get_all"
  end

end
