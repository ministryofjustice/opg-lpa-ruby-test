class Feedback
  include ActiveModel::Model
  attr_accessor :rating, :text, :email, :ip
  validates :rating, :text, :presence => true
end
