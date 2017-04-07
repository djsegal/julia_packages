class DebugLogMailer < ApplicationMailer
  def log_email debugged_name, debugged_item
    @subject = "Debug Job: #{debugged_name}"

    @debugged_item = YAML.load debugged_item

    mail_to = ENV['ADMIN_EMAIL']
    mail(to: mail_to, subject: "[Error] #{@subject}")
  end
end
