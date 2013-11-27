class Registration

  include ActiveModel::Model

  attr_accessor :username, :password

  def credentials
    { user: { email: username, password: password } }
  end
end
