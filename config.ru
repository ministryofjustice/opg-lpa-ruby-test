# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

if ENV['RACK_ENV'] == 'development'
  puts "use Clogger"
  use Clogger, :logger=> $stdout, :reentrant => true
end

run Rails.application
