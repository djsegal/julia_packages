class HomeController < ApplicationController

  def index

    @sort = params[:sort] || 'top'

    case @sort
    when 'top'
      set_top_packages
    when 'new'
      set_new_packages
    else
      raise "Invalid sorting method."
    end

    @categories = %w[
      Stats
      Optimization
      Parallel
      Database
      GPU
      Biology
      Quantum
      Astro
      Sparse
      Web
      Graphs
      Math
      DiffEq
      IO
      Interop
      Time
      Graphics
      Plots
    ]
  end

  def set_top_packages
    @packages = Package
      .includes(:counter)
      .order("counters.stargazer desc")
      .limit(10)
  end

  def set_new_packages
    @packages = Package
      .includes(:dater)
      .order("daters.created desc")
      .limit(10)
  end

end
