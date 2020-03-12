# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    showing_users = current_user&.admin? ? User.all : User.guest
    @users = showing_users.accepted_articles.all_except(current_user)
  end

  def show
    @user = User.friendly.find(params[:id])
    redirect_to home_path unless @user.articles.accepted.any? || @user == current_user || current_user&.admin?
  end

  def email_activate
    current_user.confirm
    current_user.save
    redirect_to '/'
  end

  def send_email_confirmation
    ModelMailer.new_record_notification(current_user).deliver
    redirect_to '/'
  end
end
