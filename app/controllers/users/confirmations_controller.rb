class Users::ConfirmationsController < ApplicationController

  def show
    token = params[:confirmation_token]

    response = auth_client.confirm_registration token

    if response.code == 204
      # show page on success
    else
      # show page otherwise
    end
  end

end
