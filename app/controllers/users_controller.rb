# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = current_user&.admin? ? User.all : User.guest
  end
end
