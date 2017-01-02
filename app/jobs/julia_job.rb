class JuliaJob < ApplicationJob
  queue_as :default

  def perform(*args)

    @sys_run = get_sys_run

    fetch_data

    stop_unicorn

    begin
      reset_data
    ensure
      start_unicorn
    end

  end

  private

    def get_sys_run
      sys_run_parts = [
        "RAILS_ENV=#{Rails.env}",
        "DISABLE_DATABASE_ENVIRONMENT_CHECK=1",
        "bundle exec",
        "rake"
      ]

      sys_run_parts.join ' '
    end

    def stop_unicorn
      return unless Rails.env.production?
      system "service unicorn stop"
    end

    def start_unicorn
      return unless Rails.env.production?
      system "service unicorn start"
    end

    def fetch_data

      system "#{@sys_run} metadata:pull" or \
        system "#{@sys_run} metadata:clone"

      FileUtils.rm_rf "tmp/github"
      system "#{@sys_run} github:download"

    end

    def reset_data

      system "#{@sys_run} db:drop db:create db:migrate"
      system "#{@sys_run} metadata:digest github:unpack"

    end

end
