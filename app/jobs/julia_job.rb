class JuliaJob < ApplicationJob
  queue_as :default

  def perform(*args)

    sys_run_parts = [
      "RAILS_ENV=#{Rails.env}",
      "DISABLE_DATABASE_ENVIRONMENT_CHECK=1",
      "bundle exec",
      "rake"
    ]

    sys_run = sys_run_parts.join ' '

    system "#{sys_run} metadata:pull" or \
      system "#{sys_run} metadata:clone"

    FileUtils.rm_rf "tmp/github"
    system "#{sys_run} github:download"

    system "#{sys_run} db:drop db:create db:migrate"
    system "#{sys_run} metadata:digest github:unpack"

  end
end
