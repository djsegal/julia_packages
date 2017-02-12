class ScourJob < JuliaJob
  queue_as :default

  def perform(*args)
    FileUtils.rm_rf "tmp/scour"

    system "#{@sys_run} scour:packages"
  end
end
