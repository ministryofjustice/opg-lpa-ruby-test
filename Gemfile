source 'https://rubygems.org'
source 'https://BnrJb6FZyzspBboNJzYZ@gem.fury.io/govuk/'

ruby '2.0.0'

gem 'rails', '4.0.0'

gem 'activeresource', '4.0.0'
gem 'httparty'

gem 'wicked'

gem 'haml-rails'
gem 'sass-rails', '~> 4.0.0'

gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.0.0'

gem 'numbers_and_words'

# Front-end Gems
gem 'govuk_template', '0.3.8'
gem 'govuk_frontend_toolkit', github: 'ministryofjustice/govuk_frontend_toolkit_gem', branch: 'asset-submodule'
gem 'moj_boilerplate', github: 'ministryofjustice/moj_boilerplate', tag: 'v0.3.1'

gem 'author', github: 'ministryofjustice/author', branch: 'pass-host-uri-to-client'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'multiparameter_attributes_handler'

gem 'foreman'

gem 'country_select'

gem 'rack_moj_auth', github: 'ministryofjustice/x-moj-auth'

gem 'redcarpet', '3.0.0'

group :doc do
  gem 'sdoc', require: false
end

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'thin'
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

gem 'sidekiq'

gem 'poltergeist'
