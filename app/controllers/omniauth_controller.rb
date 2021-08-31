class OmniauthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[google_oauth2]

  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      # set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      failure
    end
  end

  def failure
    flash[:error] = 'a problem signing you in'
    redirect_to new_user_registration_url
  end

  def verify_authenticity_token
    verified_request? || oauth? || raise(ActionController::InvalidAuthenticityToken)
  end
end
