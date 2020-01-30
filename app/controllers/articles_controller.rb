# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.accepted
                       .search_by_content(params[:search]).order_list(params[:sort_by])
                       .paginate(page: params[:page]).includes([:user])
  end
end
