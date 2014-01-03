class Attorney < ActiveResource::Base
  self.site = Rails.configuration.api_uri

  schema do
    string 'title', 'first_name', 'middle_names', 'last_name'
    string 'date_of_birth'
    string 'email'
    string 'phone'
    string 'occupation', 'relationship_to_donor'
  end

  has_one :address

  def initialize(*args)
    # Make sure we always have associations assigned, so that activeresource doesn't request them
    args[0] ||= {}
    args[0] = {
      :address => Address.new
    }.merge(args[0])
    super(*args)
  end

  def full_name
    "#{title} #{first_name} #{last_name}"
  end
end
