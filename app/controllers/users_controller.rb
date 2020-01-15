# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = current_user&.admin? ? User.all : User.guest
    @articles = Article.all
  end

  def show
    @users = User.find(params[:id])
    @articles = Article.find(params[:id])
  end

  private def article_params
    params.require(:article).permit(:title, :description)
  end
end
