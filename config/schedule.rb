# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "~rails/julia_observer/log/cron.log"

every :day, at: %w[ 2am 2pm 8am 8pm ] do
  rake "job:boot"
  command "echo 'boot job done.'"
end

every :day, at: %w[ 2:30am 2:30pm 8:30am 8:30pm ] do
  rake "job:download"
  command "echo 'download job done.'"
end

every :day, at: %w[ 4am 4pm 10am 10pm ] do
  rake "job:expand"
  command "echo 'expand job done.'"
end

every :day, at: %w[ 5am 5pm 11am 11pm ] do
  rake "job:update"
  command "echo 'update job done.'"
end

every :day, at: '12:30am' do
  rake "job:log"
  command "echo 'log job done.'"
end

every :day, at: '12:30pm' do
  rake "sitemap:refresh"
  command "echo 'refresh job done.'"
end

every :day, at: '6:30am' do
  rake "job:scour"
  command "echo 'scour job done.'"
end

every :day, at: '6:30pm' do
  rake "job:clean"
  command "echo 'clean job done.'"
end
