class UpdateJob < JuliaJob
  queue_as :default

  def perform(*args)

    stop_unicorn

    begin
      reset_data
    ensure
      start_unicorn
    end

  end

  private

    def stop_unicorn
      return unless Rails.env.production?
      system "service unicorn stop"
    end

    def start_unicorn
      return unless Rails.env.production?
      system "service unicorn start"
    end

    def reset_data
      system "#{@sys_run} db:drop db:create db:migrate"
      system "#{@sys_run} metadata:digest github:unpack"
    end

end
