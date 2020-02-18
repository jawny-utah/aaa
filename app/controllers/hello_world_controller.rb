# frozen_string_literal: true

class HelloWorldController < ApplicationController
  layout 'hello_world'

  def index
    @hello_world_props = { name: current_user&.nickname || 'Stranger', id: current_user&.id,
                           sort_by: params[:sort_by],
                           page: params[:page],
                           user_articles: params[:user_articles] }
  end
end
