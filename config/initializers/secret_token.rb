# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

unless Rails.env.production?
  ENV['SECRET_KEY_BASE'] = 'fa064cf19247c6416361095e9cba949e13c00dfbaaa1a3902ba6a38ffd3a8b5138db7b2c293d2449ebd53ce2844c187184239b8bb47368e72f354a48fe8006e4'
end

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
OpgLpa::Application.config.secret_key_base = ENV['SECRET_KEY_BASE']
