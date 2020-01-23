# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.accepted.search_by_content(params[:search]).paginate(page: params[:page]).includes([:user])
  end
end
