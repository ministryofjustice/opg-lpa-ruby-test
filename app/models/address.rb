class Address < ActiveResource::Base
  self.site = "http://localhost:9292/api"
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