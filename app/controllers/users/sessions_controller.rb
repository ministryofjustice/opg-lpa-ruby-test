class Users::SessionsController < ApplicationController

  def new
    if @signed_in
      redirect_to lpas_path
    else
      @session = Session.new
    end
  end

  def create
    @session = Session.new(params[:session])

    response = auth_client.login @session.email, @session.password

    if response.code == 201
      reset_session
      store_secure_token response['authentication_token']

      with_secure_token(Applicant) do
        if applicant = Applicant.current_applicant
          store_applicant_name(applicant)
          redirect_to controller: '/lpas', action: 'index'
        else
          redirect_to new_applicant_path
        end
      end
    else
      set_validation_messages response, @session
      @session.password = nil
      render :template => '/users/sessions/new'
    end
  end

  def destroy
    destroy_secure_token
    reset_session
    redirect_to "/"
  end

  private

  def destroy_secure_token
    if read_secure_token
      auth_client.logout(read_secure_token)
    end
    Rails.cache.delete(secure_token_cache_key)
  end

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
