class Attorney < ActiveResource::Base
  self.site = "http://localhost:9292/api"
	schema do
	  string  'title', 'first_name'
	end
end