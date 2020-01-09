class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  def authenticate_admin_user!
    redirect_to "/" if !current_user || !current_user.admin?
  end
end
