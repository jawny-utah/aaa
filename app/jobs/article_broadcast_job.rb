# frozen_string_literal: true

class ArticleBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    slug = user.slug
    ActionCable.server.broadcast "articles_#{slug}", {}
  end
end
