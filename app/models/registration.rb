class Registration

  include ActiveModel::Model

  attr_accessor :email, :password

  def credentials
    { user: { email: email, password: password } }
  end
end
