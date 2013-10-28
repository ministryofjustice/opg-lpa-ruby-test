class Attorney < ActiveResource::Base
  self.site = "http://localhost:9292/api"
	schema do
	  string  'title', 'first_name'
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

end