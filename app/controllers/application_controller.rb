class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :track_action
  before_action :redirect_to_root, only: [:new, :edit]
  before_action :block_changes, only: [:create, :update]

  if Rails.env.production?
    caught_errors = [
      StandardError
    ]

    caught_errors.each do |caught_error|
      rescue_from caught_error, \
        with: :error_render_method
    end
  end

  def error_render_method
    render 'layouts/error_page', status: 404
  end

  private

    def redirect_to_root
      redirect_to root_url.sub('cdn.', '')
    end

    def block_changes
      throw "Changing objects is not allowed."
    end

  protected

    def track_action
      ahoy.track "Viewed #{controller_name}##{action_name}"
    end

end
