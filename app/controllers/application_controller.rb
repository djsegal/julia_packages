class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  if Rails.env.production?
    rescue_from \
      StandardError, \
      with: :error_render_method
  end

  def error_render_method
    render 'layouts/error_page'
  end
end
