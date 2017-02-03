class UpdateJob < JuliaJob
  queue_as :default

  def perform(*args)

    Batch.current_marker += 1
    set_batch_marker :current, Batch.current_marker

    system "#{@sys_run} db:migrate"
    system "#{@sys_run} metadata:digest"
    system "#{@sys_run} github:unpack"
    system "#{@sys_run} news:make"

    marker_list = [Batch.current_marker, Batch.active_marker]
    batch_counts = \
      Batch.where(marker: marker_list).group(:marker).count

    return if batch_counts.empty?
    return unless \
      batch_counts[Batch.current_marker].present?

    percent_change = get_percent_change batch_counts
    return if \
      percent_change.present? && percent_change > 25

    Batch.active_marker = Batch.current_marker
    set_batch_marker :active, Batch.active_marker

    system "service unicorn restart" \
      if Rails.env.production?

  end

  private

    def set_batch_marker marker_type, new_value
      batch_directory = 'tmp/batch'
      file_name = "#{marker_type}.yml"
      file_path = "#{batch_directory}/#{file_name}"

      File.open(file_path, 'w') do |h|
        h.puts new_value.to_yaml
      end
    end

    def get_percent_change batch_counts
      return if ( batch_counts.length != 2 )

      batch_difference = batch_counts.values.first
      batch_difference -= batch_counts.values.second
      batch_difference *= 100.0
      batch_difference /= batch_counts.values.max
      batch_difference.abs
    end

end
