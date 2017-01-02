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

every :day, at: '12:34 am' do
  rake "job:boot"
end

every :day, at: '1:11 am' do
  rake "job:download"
end

every :day, at: '3:00 am' do
  rake "job:expand"
end

every :day, at: '4:04 am' do
  rake "job:update"
end
