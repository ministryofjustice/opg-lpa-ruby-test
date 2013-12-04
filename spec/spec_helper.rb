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

  # VCR config
  # config.configure_rspec_metadata!
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name) { example.call }
  end
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
  fill_in 'Email (optional)', with: overides[:email] || "johnny@example.com"
  fill_in 'Phone (optional)', with: (overides[:phone] || "123 456") unless overides[:no_phone]
end

def fill_in_valid_donor(overides={})
  fill_in_valid_person(overides)
  select 31, from: 'lpa_donor_date_of_birth_3i'
  select 'January', from: 'lpa_donor_date_of_birth_2i'
  select 1970, from: 'lpa_donor_date_of_birth_1i'
end

def fill_in_valid_attorney(overides={})
  fill_in_valid_person(overides)
  select 31, from: 'attorney_date_of_birth_3i'
  select 'January', from: 'attorney_date_of_birth_2i'
  select 1970, from: 'attorney_date_of_birth_1i'
end

def fill_in_valid_applicant(overides={})
  fill_in_valid_person(overides)
  select 31, from: 'applicant_date_of_birth_3i'
  select 'January', from: 'applicant_date_of_birth_2i'
  select 1970, from: 'applicant_date_of_birth_1i'
end

def unique_email
  "joe.bloggs#{Time.now.to_f}#{rand(1000)}@example.com"
end

def valid_password
  's3kr!tpass'
end

def fill_in_sign_up(overrides={})
  @email = overrides[:email] || unique_email
  fill_in 'Enter your email address', with: @email
  fill_in 'Create a password',        with: overrides[:password] || valid_password
end

def fill_in_sign_in(overrides={})
  fill_in 'Email address', with: overrides[:email] || @email
  fill_in 'Password',      with: overrides[:password] || valid_password
end

def sign_up_and_sign_in
  visit "/users/sign_up"
  fill_in_sign_up
  click_button "I understand"
  expect(page).to have_content('Please check your email')
  click_link "sign in now"
  fill_in_sign_in
  click_button "Sign in"
end

def create_financial_lpa(overides={})
  visit "/applicants/new"
  fill_in_valid_person(overides)
  click_button "Save and continue"

  click_button "Create a new LPA"

  expect(page).to have_content('What type of LPA do you want to create?')
  choose("Property and financial affairs")

  click_button "Save and continue"
end

def create_healthcare_lpa(overides={})
  visit "/applicants/new"
  fill_in_valid_person(overides)
  click_button "Save and continue"

  click_button "Create a new LPA"

  expect(page).to have_content('What type of LPA do you want to create?')
  choose("Health and welfare")

  click_button "Save and continue"
end

