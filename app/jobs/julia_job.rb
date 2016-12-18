class JuliaJob < ApplicationJob
  queue_as :default

  def perform(*args)

    system "rake metadata:pull" or \
      system "rake metadata:clone"

    FileUtils.rm_rf "tmp/github"
    system "rake github:download"

    system "rake db:drop db:create db:migrate"
    system "rake metadata:digest github:unpack"
    system "rake db:seed"

  end
end
