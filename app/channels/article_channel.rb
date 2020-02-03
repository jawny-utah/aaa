class ArticleChannel < ApplicationCable::Channel
  def subscribed
    stream_from "articles_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
