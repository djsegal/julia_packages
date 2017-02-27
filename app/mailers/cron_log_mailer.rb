class CronLogMailer < ApplicationMailer
  def log_email cron_job, failure_log
    @subject = "Failed Job: #{cron_job}"

    @log_file = YAML.load failure_log

    mail_to = ENV['ADMIN_EMAIL']
    mail(to: mail_to, subject: "[Error] #{@subject}")
  end
end
