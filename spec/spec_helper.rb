# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
ENV['API_HOST'] ||= 'http://localhost:9292'

unless ENV['HOME'].to_s[/\/Users/]
  # Coveralls for code coverage on Travis builds
  require 'coveralls'
  Coveralls.wear!
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'webmock/rspec'
require 'capybara/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def fill_in_valid_person(overides={})
  fill_in 'Title', with: overides[:title] || "Mr"
  fill_in 'First name', with: overides[:first_name] || "Johnny"
  fill_in 'Last name', with: overides[:last_name] || "Smithson"
  fill_in 'Post code', with: overides[:post_code] || "SW1H 9AJ"
  fill_in 'Street', with: overides[:address_line1] || "102 Petty France"
  fill_in 'Town', with: overides[:town] || "Westminster"
  fill_in 'County', with: overides[:county] || "London"
  fill_in 'Country', with: overides[:country] || "Great Britain"
end

def fill_in_valid_donor(overides={})
  fill_in_valid_person(overides)
  select 31, from: 'lpa_donor_date_of_birth_3i'
  select 'January', from: 'lpa_donor_date_of_birth_2i'
  select 1970, from: 'lpa_donor_date_of_birth_1i'
end

