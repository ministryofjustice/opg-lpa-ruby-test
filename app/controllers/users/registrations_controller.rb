class ApiClient
  include HTTParty
  base_uri 'http://localhost:9292'
end

class Users::RegistrationsController < ApplicationController

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])

    # binding.pry
    response = ApiClient.post('/auth/users.json', body: @registration.credentials)
    # binding.pry
    # File.open('response.html','w') {|f| f.write response.body}
    if response.code == 201
      # success
    else
      render :template => '/users/registrations/new'
    end
  end

end

