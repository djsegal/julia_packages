module ApplicationHelper

  def format_website_link website
  	return unless website.present?
  	return website if website.starts_with? 'http'
  	"http://#{website}"
  end

end
