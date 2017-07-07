class BootJob < JuliaJob
  queue_as :default

  def perform(*args)
    boot_repos = %w[ metadata decibans ]

    boot_repos.each do |boot_repo|
      next if system "#{@sys_run} #{boot_repo}:pull"
      next if system "#{@sys_run} #{boot_repo}:clone"
      system "#{@sys_run} #{boot_repo}:reset"
    end
  end

end
