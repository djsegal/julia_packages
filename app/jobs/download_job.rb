class DownloadJob < JuliaJob
  queue_as :default

  def perform(*args)
    FileUtils.rm_rf "tmp/github"

    system "#{@sys_run} github:download"
  end

end
