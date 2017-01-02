class DownloadJob < JuliaJob
  queue_as :default

  def perform(*args)
    system "#{@sys_run} github:download"
  end

end
