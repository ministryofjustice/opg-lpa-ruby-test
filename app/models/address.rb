class Address < ActiveResource::Base
  self.site = Rails.configuration.api_uri
  schema do
    string  'address_line1'
    string  'address_line2'
    string  'address_line3'
    string  'town'
    string  'county'
    string  'post_code'
    string  'country'
  end
end