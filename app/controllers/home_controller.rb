class HomeController < ApplicationController
  def index
    @packages = Package
      .includes(:counter)
      .order("counters.stargazer desc")
      .limit(10)

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
end
