class CleanJob < ApplicationJob
  queue_as :default

  def perform(*args)

    Batch.connection

    start_batch = 1
    end_batch = Batch.active_marker-1

    purge_batch_range start_batch, end_batch

    start_batch = Batch.active_marker+1
    end_batch = Batch.current_marker-1

    purge_batch_range start_batch, end_batch

  end

  private

    def purge_batch_range start_batch, end_batch
      batch_range = start_batch..end_batch
      return if batch_range.count.zero?

      Batch.where(marker: batch_range).reload
      Batch.where(marker: batch_range).destroy_all
    end

end
