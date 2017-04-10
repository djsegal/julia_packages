class StaticsController < ApplicationController
  def about
    @package_name = "Julia Observer"
    @package_description = "julia language package browser 🔎"

    @package_owner = "djsegal"
  end
end
