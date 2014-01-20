require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_model"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require 'active_resource'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

puts "==== RAILS_ENV: #{ENV['RAILS_ENV']}"

ENV['API_HOST'] ||= 'http://localhost:9292'
ENV['SITE_URL'] ||= 'http://localhost:3000' if Rails.env.development?

module OpgLpa
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    #======= MOJ Boilerplate variables =======#
    # app title appears in the header bar
    config.app_title = 'Make a lasting power of attorney'
    # phase governs text indicators and highlight colours
    # presumed values: alpha, beta, live
    config.phase = 'beta'
    # product type may also govern highlight colours
    # known values: information, service
    config.product_type = 'service'
    # feedback link url
    config.feedback_url = '#'
    # Google Analytics tracking ID
    config.ga_id = ''


    config.api_uri = "#{ENV['API_HOST']}/api"

    # include Bower components in compiled assets
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
  end
end
