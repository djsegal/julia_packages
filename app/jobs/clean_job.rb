class CleanJob < ApplicationJob
  queue_as :default

  def perform(*args)
    batch_range = 0..(Batch.active_marker-1)
    Batch.where(marker: batch_range).destroy_all
  end
end
