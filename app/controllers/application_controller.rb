class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  if Rails.env.production?
    caught_errors = [
      ActionView::Template::Error,
      StandardError
    ]

    caught_errors.each do |caught_error|
      rescue_from caught_error, \
        with: :error_render_method
    end
  end

  def error_render_method
    render 'layouts/error_page'
  end
end
