Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN'] # Add your DSN from Sentry here or as an environment variable
  config.environment = Rails.env # Set the environment (development or production)
  config.release = ENV['HEROKU_RELEASE_VERSION'] || 'development' # Optionally track the release
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Optionally, you can track performance
  config.traces_sample_rate = 0.5 # Adjust this value for sampling performance monitoring
end
