class Users::RegistrationsController < ApplicationController

  def new
    if @signed_in
      redirect_to lpas_path
    else
      @registration = Registration.new
    end
  end

  def create
    @registration = Registration.new(params[:registration])

    response = auth_client.register @registration.email, @registration.password

    if response.code == 201
      @confirmation_token = response['confirmation_token']
      SignUpConfirmer.signup_email(@registration.email, @confirmation_token).deliver
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
