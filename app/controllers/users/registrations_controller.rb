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

    response = ApiClient.post('/auth/users', body: @registration.credentials)

    if response.code == 201
      # success
    else
      set_validation_messages response, @registration
      render :template => '/users/registrations/new'
    end
  end

  private

  def set_validation_messages response, resource
    errors = JSON.parse response.body
    if messages = errors['errors']
      messages.each do |field, list|
        list.each do |message|
          resource.errors.add(field, message)
        end
      end
    end
  end

end

