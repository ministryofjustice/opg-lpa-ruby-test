class Applicant < ActiveResource::Base
  self.site = Rails.configuration.api_uri

  has_many :lpas
  has_one :address

  schema do
    string 'title'
    string 'first_name'
    string 'middle_names'
    string 'last_name'
    string 'date_of_birth'
    string 'email'
    string 'phone'
  end

  class << self
    def headers= headers
      @headers = headers
    end
  end

  def initialize(*args)
    # Make sure we always have associations assigned, so that activeresource doesn't request them
    args[0] ||= {}
    args[0] = {
      :address => Address.new,
      :lpas => []
    }.merge(args[0])
    super(*args)
  end

  def secure_token= token
    # if token
      self.class.headers = self.class.headers.merge('X-SECURE-TOKEN' => token)
    # else
      # self.class.headers = self.class.headers.except('X-SECURE-TOKEN')
    # end
  end

end

