class ApiClient
  include HTTParty
  base_uri 'http://localhost:9292'
end

class Users::SessionsController < ApplicationController

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(params[:session])

    response = ApiClient.post('/login', body: @session.credentials)

    if response.code == 200
      session[:secure_token] = response['token']
      redirect_to new_applicant_path
    else
      @session.password = nil
      render :template => '/users/sessions/new'
    end
  end

end

