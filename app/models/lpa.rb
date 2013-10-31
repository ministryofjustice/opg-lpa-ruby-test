class Lpa < ActiveResource::Base
  self.site = Rails.configuration.api_uri

  has_many :attorneys
  has_many :replacement_attorneys, :class_name => :attorney
  has_one :donor

  schema do
    string  'type'
    string  'when_to_use'
    string  'life_sustaining_treatment'
  end

  def initialize(*args)
    # Make sure we always have associations assigned, so that activeresource doesn't request them
    args[0] ||= {}
    args[0] = {
      :donor => nil,
      :attorneys => [],
      :replacement_attorneys => []
    }.merge(args[0])
    super(*args)
  end
end
