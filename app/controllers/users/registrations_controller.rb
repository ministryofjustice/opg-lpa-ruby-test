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
    binding.pry
    credi = {body: {username: 'joe.bloggs@example.com', password: 's3kr!t'} }
    resp = ApiClient.post('/register', @good_creds)

  end

end

