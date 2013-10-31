class Donor < ActiveResource::Base
  self.site = Rails.configuration.api_uri
  has_one :address

  def initialize(*args)
    # Make sure we always have associations assigned, so that activeresource doesn't request them
    args[0] ||= {}
    args[0] = {
      :address => Address.new
    }.merge(args[0])
    super(*args)
  end

  schema do
    string  'title', 'first_name', 'middle_names', 'last_name'
  end
end
