class BootJob < JuliaJob
  queue_as :default

  def perform(*args)
    system "#{@sys_run} metadata:pull" or \
      system "#{@sys_run} metadata:clone"
  end

end
