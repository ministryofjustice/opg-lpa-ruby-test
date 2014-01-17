class Users::ConfirmationsController < ApplicationController

  def show
    token = params[:confirmation_token]

    response = auth_client.confirm_registration token

    if response.code == 204
      redirect_to users_new_session_path
    else
      redirect_to users_new_session_path
    end
  end

end
