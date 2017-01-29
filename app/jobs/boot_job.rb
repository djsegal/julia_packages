class BootJob < JuliaJob
  queue_as :default

  def perform(*args)
    return if system "#{@sys_run} metadata:pull"
    return if system "#{@sys_run} metadata:clone"
    system "#{@sys_run} metadata:reset"
  end

end
