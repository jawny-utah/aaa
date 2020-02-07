# frozen_string_literal: true

class Api::V1::ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles, each_serializer: ArticleSerializer
  end
end
