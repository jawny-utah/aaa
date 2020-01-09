class UsersController < ApplicationController
  def index
    @users = current_user&.admin? ? User.all : User.guest
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
end
