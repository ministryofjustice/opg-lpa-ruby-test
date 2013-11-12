class Session

  include ActiveModel::Model

  attr_accessor :username, :password

  def credentials
    { username: username, password: password }
  end
end
