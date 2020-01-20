class ArticlesController < ApplicationController
  def index
    @articles = Article.accepted.paginate(page: params[:page])
  end
end
