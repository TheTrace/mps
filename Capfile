# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#
require 'capistrano/rvm'
# We're going to use the full capistrano/rails since
# it includes the asset compilation, DB migrations
# and bundler
require 'capistrano/rails'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
# Original
# Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
# From one istallation suggestion
# Dir.glob('lib/capistrano/**/*.rb').each { |r| import r }
# Quick fix for cap v2 installation
# Rake::Task[:production].invoke
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
