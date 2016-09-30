# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Manage capistrano files
require 'capistrano/figaro_yml'

require 'capistrano/rails'

require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

require 'capistrano/puma'

# require 'capistrano/foreman'
# require 'capistrano/delayed_job'
require 'capistrano/sidekiq'

# Default settings
set :foreman_use_sudo, false # Set to :rbenv for rbenv sudo, :rvm for rvmsudo or true for normal sudo
set :foreman_roles, :all
set :foreman_template, 'upstart'
set :foreman_export_path, ->{ File.join(Dir.home, '.init') }
set :foreman_options, ->{ {
  app: application,
  log: File.join(shared_path, 'log')
} }



# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
