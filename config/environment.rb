# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Remove this with better errors
Rails.application.config.consider_all_requests_local = true
