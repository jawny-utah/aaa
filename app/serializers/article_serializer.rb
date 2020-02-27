# frozen_string_literal: true

class ArticleSerializer < ApplicationSerializer
  attributes :title, :description, :id, :user_id, :created_at, :user_email, :user_ids
end
