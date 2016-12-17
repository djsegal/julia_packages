class HomeController < ApplicationController

  def index
    @sort = params[:sort] || 'top'

    case @sort
    when 'top'
      set_top_packages
    when 'new'
      set_new_packages
    when 'pop'
      set_pop_packages
    else
      raise "Invalid sorting method."
    end

    @categories = Category.all
  end

  def set_top_packages
    @packages = Package
      .includes(:counter)
      .order("counters.stargazer desc")
      .paginate(page: params[:page])
  end

  def set_new_packages
    @packages = Package
      .includes(:dater)
      .order("daters.created desc")
      .paginate(page: params[:page])
  end

  def set_pop_packages
    live_packages = Package
      .includes(:dater)
      .where("daters.pushed > ?", 4.months.ago)
      .order("daters.pushed desc")
      .paginate(page: params[:page])

    dead_packages = Package
      .includes(:dater)
      .where.not("daters.pushed > ?", 4.months.ago)
      .order("daters.pushed desc")
      .paginate(page: params[:page])

    @packages = live_packages.or(dead_packages)
  end

end
