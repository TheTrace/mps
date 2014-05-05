source 'https://rubygems.org'
#ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Be sure to include rake in your Gemfile
gem 'rake'
 
# Use Capistrano for deployment
gem 'capistrano', '~> 3.0', require: false, group: :development
gem 'capistrano-rvm'

group :development, :test do
	# Use sqlite3 as the database for Active Record
	gem 'sqlite3'
	gem 'capistrano-rails',   '~> 1.1', require: false
	gem 'capistrano-bundler', '~> 1.1', require: false
end

group :production do
	#gem 'pg', '0.15.1'
	#gem 'rails_12factor', '0.0.2'
	gem 'mysql2'
end

gem 'haml'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 3.1.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'


# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'therubyracer'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.2.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
