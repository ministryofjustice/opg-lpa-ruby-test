class ApiClient
  include HTTParty
  base_uri ENV['API_HOST']
end

class Users::RegistrationsController < ApplicationController

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])

    response = ApiClient.post('/auth/users.json', body: @registration.credentials)

    if response.code == 201
      # success
    else
      render :template => '/users/registrations/new'
    end
  end

end

