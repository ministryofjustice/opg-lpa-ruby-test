class ApiClient
  include HTTParty
  base_uri ENV['API_HOST']
end

class Users::SessionsController < ApplicationController

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(params[:session])

    response = ApiClient.post('/auth/users/sign_in', body: @session.credentials)

    if response.code == 201
      reset_session
      store_secure_token response['authentication_token']

      with_secure_token(Applicant) do
        if applicant = Applicant.current_applicant
          store_applicant_name(applicant)
        end
      end
      redirect_to new_applicant_path
    else
      set_validation_messages response, @session
      @session.password = nil
      render :template => '/users/sessions/new'
    end
  end

  private

  def store_secure_token token
    Rails.cache.write(secure_token_cache_key, token)
  end

  def set_validation_messages response, resource
    errors = JSON.parse response.body
    if message = errors['error']
      resource.errors.add(:note, message)
    end
  end

end

