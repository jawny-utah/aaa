# frozen_string_literal: true

class Api::V1::ArticlesController < ApplicationController
  def index
    render json: articles, each_serializer: ArticleSerializer
  end

  def articles
    @articles ||= Article.order_list(params[:sort_by])
  end
end
