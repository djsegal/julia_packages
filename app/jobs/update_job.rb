class UpdateJob < JuliaJob
  queue_as :default

  def perform(*args)

    Batch.current_marker += 1
    set_batch_marker :current, Batch.current_marker

    system "#{@sys_run} db:migrate"
    system "#{@sys_run} metadata:digest"
    system "#{@sys_run} scour:devour"
    system "#{@sys_run} github:unpack"
    system "#{@sys_run} news:make"
    system "#{@sys_run} crawl:feed"
    system "#{@sys_run} decibans:digest"
    system "#{@sys_run} require:all"

    batch_count = Batch.where(marker: Batch.current_marker).count
    return unless batch_count > 2500

    Batch.active_marker = Batch.current_marker
    set_batch_marker :active, Batch.active_marker

    Batch.active_marker_date = Batch.current_marker_date
    set_batch_marker :active_date, Batch.active_marker_date

    system "rails restart" if Rails.env.production?

    system "#{@sys_run} downloads:packages"

  end

end
