class JuliaJob < ApplicationJob
  queue_as :default

  def perform(*args)

    sys_run = "RAILS_ENV=#{Rails.env} rake"

    system "#{sys_run} metadata:pull" or \
      system "#{sys_run} metadata:clone"

    FileUtils.rm_rf "tmp/github"
    system "#{sys_run} github:download"

    system "#{sys_run} db:drop db:create db:migrate"
    system "#{sys_run} metadata:digest github:unpack"
    system "#{sys_run} process:categories"

  end
end
