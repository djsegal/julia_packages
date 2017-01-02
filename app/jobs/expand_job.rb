class ExpandJob < JuliaJob
  queue_as :default

  def perform(*args)
    system "#{@sys_run} github:expand"
  end

end
