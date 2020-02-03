class ArticleBroadcastJob < ApplicationJob
  queue_as :default

  def perform(article)
    # Do something later
    slug = article.user.slug
    ActionCable.server.broadcast "articles_#{slug}", item: render_article(article)
  end

  private

  def render_article(article)
    ArticlesController.render(
      partial: 'articles/article',
      locals: {
        article: article
      }
    )
  end
end
