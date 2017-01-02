class BootJob < JuliaJob
  queue_as :default

  def perform(*args)

    remove_old_content

    setup_metadata_repo

  end

  private

    def remove_old_content
      FileUtils.rm "log/cron.log", force: true
      FileUtils.rm_rf "tmp/github"
    end

    def setup_metadata_repo
      system "#{@sys_run} metadata:pull" or \
        system "#{@sys_run} metadata:clone"
    end

end
