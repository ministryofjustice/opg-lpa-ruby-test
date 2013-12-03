require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.join('spec', 'vcr')
  c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!

  if ENV["VCR"] == "false"
    WebMock.allow_net_connect!
    c.ignore_request { |request| true }
  end
end
