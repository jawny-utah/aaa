# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  # before_action :authenticate_user!
  def authenticate_admin_user!
    redirect_to '/' if !current_user || !current_user.admin?
  end
end
