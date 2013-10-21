class Lpa
  include ActiveModel::Model
  attr_accessor :id, :title, :first_name, :errors

  Host = "http://127.0.0.1"

  def persisted?
    true
  end

  def id
    3
  end

  def update(params)
    response = Typhoeus.put Host, body: params
    if response.success?
      true
    else
      self.errors = JSON.parse(response.body)["errors"] if response.body.present?
      false
    end
  end
end
