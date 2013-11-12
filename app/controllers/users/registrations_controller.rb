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

    response = ApiClient.post('/register', body: @registration.credentials)

    if response.code == 201
      # success
    else
      render :template => '/users/registrations/new'
    end
  end

end

