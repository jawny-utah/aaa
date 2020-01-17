# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    showing_users = current_user&.admin? ? User.all : User.guest
    @users = showing_users.accepted_articles.all_except(current_user)
  end

  def show
    @user = User.friendly.find(params[:id])
    redirect_to home_path unless @user.articles.accepted.any? || @user == current_user
  end
end
