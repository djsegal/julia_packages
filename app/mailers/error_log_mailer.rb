class ErrorLogMailer < ApplicationMailer
  def log_email bad_class, bad_slug, bad_referrer, bad_params
    @bad_object = {
      type: bad_class,
      slug: bad_slug,
      referrer: bad_referrer,
      params: bad_params
    }

    @subject = "Bad "
    if bad_class.underscore == 'error'
      @subject += "Route: "
      @subject += @bad_object[:params]['bad_route']
    elsif bad_slug.present?
      @subject += "#{ @bad_object[:type] }: "
      @subject += "#{ @bad_object[:slug] }"
    else
      @subject += @bad_object[:type].pluralize
    end

    @log_file = tail "./log/#{Rails.env}.log", 500

    mail_to = ENV['ADMIN_EMAIL']
    mail(to: mail_to, subject: "[Error] #{@subject}")
  end
end
