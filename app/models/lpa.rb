class Lpa
  include ActiveModel::Model
  attr_accessor :id, :title, :first_name

  Host = "http://blargh"

  def persisted?
  	true
  end

  def id
  	3
  end

  def update(params)
  	RestClient.put Host, params, :content_type => :json, :accept => :json
  rescue RestClient::BadRequest
  	false
  end
end
