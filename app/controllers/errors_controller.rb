class ErrorsController < ApplicationController
  def index
    render 'layouts/error_page', status: 404
  end

  def pardon
  end
end
