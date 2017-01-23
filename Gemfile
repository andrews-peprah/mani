source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano', "~> 3.7", require: false
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-figaro-yml', '~> 1.0.2'
  gem 'capistrano-rvm', github: "capistrano/rvm"
  gem 'capistrano3-puma'
  gem 'capistrano-sidekiq', group: :development
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Authentication
gem 'devise'

# Parameters
# gem 'strong_parameters'

# API
gem 'grape'

# Money and currency
gem 'money'

# Country 
gem 'countries'

# File uploads
gem 'carrierwave'

# Concurrency
gem 'sidekiq'

# Behaviour Driven development
gem "rspec-rails", :group => [:development, :test]

# Doorkeeper for oauth
gem 'doorkeeper'

# Gritter gem for notification
gem 'gritter'

# HTTP gem for http requests
gem 'http'

# Unique ID gem for unique identification
gem 'uuid'

# GCM for push notification
gem 'gcm'

# Figaro gem for environment variables
gem 'figaro'

# Newrelic to monitor application performance
gem 'newrelic_rpm'