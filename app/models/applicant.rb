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
  end

  class << self
    def headers= headers
      @headers = headers
    end

    def current_applicant
      begin
        Applicant.find(:current)
      rescue ActiveResource::ForbiddenAccess
        nil
      end
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

  def has_lpa?(lpa_id)
    self.lpas.map(&:id).include? lpa_id
  end
end

