module ApplicationHelper

  def format_website_link website
    return unless website.present?
    return website if website.starts_with? 'http'
    "http://#{website}"
  end

  def page_title title
    content_for(:page_title) { title }
  end

end
