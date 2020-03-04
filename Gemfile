source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails-assets-bootstrap-material-design', '0.5.10', source: 'https://rails-assets.org'

gem 'annotate'

gem 'font-awesome-rails'

gem 'httparty'

gem 'will_paginate', '~> 3.1.0'

gem 'friendly_id'

gem 'rails-jquery-autocomplete'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'bullet', :group => 'development'

gem 'rake-progressbar'

gem 'redcarpet'

gem 'RbST'

gem 'underscore-rails'

gem 'rack-cors', :require => 'rack/cors'

gem 'whenever', :require => false

gem 'sitemap_generator'

gem 'chartkick'

gem 'lograge'

gem 'nokogiri', '1.6.8.1'

gem 'premailer-rails'

gem 'bootstrap-sass', '~> 3.3.6'

gem 'delayed_job_active_record'

gem 'daemons'

gem 'redd', '~> 0.7'

gem 'acts_as_list'

gem 'js_cookie_rails'

gem 'discourse_api'

gem 'dalli'

gem 'spreadsheet'

gem 'rubyzip'

gem 'time_difference'

gem 'pg_search'

gem 'pg', '~> 0.21'

gem 'ahoy_matey', '1.6'

gem 'groupdate'

gem 'activerecord-import'

gem 'clipboard-rails'

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'letter_opener'
  gem "better_errors"
  gem "binding_of_caller"
end

group :production do
  gem 'unicorn'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.1.rc2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
