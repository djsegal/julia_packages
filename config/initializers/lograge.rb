Rails.application.configure do
  
  config.lograge.enabled = true

  config.lograge.formatter = Lograge::Formatters::Graylog2.new
  
  # add time to lograge
  config.lograge.custom_options = lambda do |event|
    {:time => event.time}
  end

end
