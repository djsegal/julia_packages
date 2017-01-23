class ErrorLogMailer < ApplicationMailer
  def log_email bad_class, bad_slug
  	@bad_object = {
  		type: bad_class,
  		slug: bad_slug
  	}

    subject = "[Error] Bad "
    subject += "#{ @bad_object[:type] }: "
    subject += "#{ @bad_object[:slug] }"

		@log_file = tail "./log/#{Rails.env}.log", 200

    mail(to: 'dan@seg.al', subject: subject)
  end
end
