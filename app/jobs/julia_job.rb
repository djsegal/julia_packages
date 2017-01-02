class JuliaJob < ApplicationJob
  queue_as :default

  before_perform :set_sys_run

  def perform(*args)
    raise "Perform should be overwritten by subclass."
  end

  private

    def set_sys_run
      sys_run_parts = [
        "RAILS_ENV=#{Rails.env}",
        "DISABLE_DATABASE_ENVIRONMENT_CHECK=1",
        "bundle exec",
        "rake"
      ]

      @sys_run = sys_run_parts.join ' '
    end

end
