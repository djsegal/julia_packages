if Rails.env.production?

  log_file = \
    File.join Rails.root, 'log', 'delayed_job.log'

  Delayed::Worker.logger = \
    Logger.new log_file

  if caller.last =~ /script\/delayed_job/ or (File.basename($0) == "rake" and ARGV[0] =~ /jobs\:work/)
    ActiveRecord::Base.logger = Delayed::Worker.logger
  end

  ActionMailer::Base.logger = Delayed::Worker.logger

  module Delayed
    module Backend
      module ActiveRecord
        class Job
          class << self

            alias_method :reserve_original, :reserve

            def reserve(worker, max_run_time = Worker.max_run_time)
              previous_level = ::ActiveRecord::Base.logger.level
              ::ActiveRecord::Base.logger.level = Logger::WARN if previous_level < Logger::WARN

              value = reserve_original(worker, max_run_time)
              ::ActiveRecord::Base.logger.level = previous_level

              value
            end

          end
        end
      end
    end
  end

end
