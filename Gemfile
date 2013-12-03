source 'https://rubygems.org'
source 'https://BnrJb6FZyzspBboNJzYZ@gem.fury.io/govuk/'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'thin'
gem 'sidekiq'

gem 'activeresource', '4.0.0'
gem 'httparty'

gem 'wicked'

gem 'haml-rails'
gem 'sass-rails', '~> 4.0.0'

gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.0.0'

# Front-end Gems
gem 'govuk_template'
gem 'govuk_frontend_toolkit'
# gem 'moj_frontend_toolkit_gem', git: 'https://github.com/ministryofjustice/moj_frontend_toolkit_gem.git', tag: 'v0.0.40'
# local boilerplate
gem 'moj_boilerplate', git: 'https://github.com/ministryofjustice/moj_boilerplate.git'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'multiparameter_attributes_handler'

gem 'foreman'

gem 'rack_moj_auth', github: 'ministryofjustice/x-moj-auth'

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'byebug'
  gem 'launchy'
  gem 'clogger' # Rack middleware for logging HTTP requests
end

group :test do
  gem 'webmock'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'coveralls', require: false
  gem 'vcr', '2.7.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# performance monitoring
gem 'newrelic_rpm'
