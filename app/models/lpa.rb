class Lpa < ActiveResource::Base
  self.site = Rails.configuration.api_uri

  has_many :attorneys
  has_many :replacement_attorneys, :class_name => :attorney
  has_one :donor
  has_one :certificate_provider
  has_one :certificate_provider2, :class_name => :certificate_provider
  has_many :people_to_be_told

  schema do
    string 'type'
    string 'when_to_use'
    string 'life_sustaining_treatment'
    string 'how_attorneys_act'
    string 'how_attorneys_act_details'
    string 'how_replacement_attorneys_act'
    string 'how_replacement_attorneys_act_details'
    string 'status'
    string 'registrant' #should probably add a registrant/registration model which belongs to lpa
    string 'another_lpa'
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
      :donor => nil,
      :certificate_provider => nil,
      :certificate_provider2 => nil,
      :people_to_be_told => [],
      :attorneys => [],
      :replacement_attorneys => []
    }.merge(args[0])
    super(*args)
  end

end

