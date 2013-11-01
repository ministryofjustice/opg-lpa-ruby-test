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

  def full_address
    "#{address_line1} #{address_line2} #{address_line3} #{town} #{county} #{post_code}"
  end
end