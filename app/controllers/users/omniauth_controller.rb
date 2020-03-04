# frozen_string_literal: true

class Users::OmniauthController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      flash[:notice] = 'Login success'
    else
      redirect_to new_user_registration_url
    end
  end

  def facebook
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      flash[:notice] = 'Login success'
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:notice] = 'Login failed'
    redirect_to home_path
  end
end
