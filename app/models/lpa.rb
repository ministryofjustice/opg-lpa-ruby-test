class Lpa < ActiveResource::Base
  self.site = "http://localhost:9292/api"
  
  has_many :attorneys
  has_one :donor

  schema do
    string  'type'
  end

  def initialize(hash={})
    # Make sure we always have associations assigned, so that activeresource doesn't request them
    defaults = {
      :donor => Donor.new,
      :attorneys => []
    }
    super(defaults.merge(hash))
  end

  # def attorneys_attributes=(attributes)
  #   # Process the attributes hash
  # end

  # def donor
  #   if @donor.blank?
  #     Donor.new
  #   else
  #     super
  #   end
  # end
end
