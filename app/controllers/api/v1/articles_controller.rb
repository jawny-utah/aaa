# frozen_string_literal: true

class Api::V1::ArticlesController < ApplicationController
  def index
    render json: serialize(articles, ArticleSerializer)
                   .merge(page_count: articles.total_pages)
  end

  def articles
    @articles ||= Article.order_list(params[:sort_by]).paginate(page: params[:page]).includes([:user])
  end
end
