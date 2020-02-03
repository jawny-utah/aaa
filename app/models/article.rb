# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user, optional: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :user_id }
  scope :search_by_content, ->(query) {
    return if query.blank?
    where('title ILIKE:query OR description ILIKE:query', query: "%#{query}%")
  }
  after_create_commit {
    ArticleBroadcastJob.perform_later(self)
  }

  after_update_commit {
    ArticleBroadcastJob.perform_later(self)
  }

  after_destroy {
    ArticleBroadcastJob.perform_later(self)
  }

  scope :accepted, -> { where(accepted: true) }
  scope :sort_by_title, -> { order(title: :asc) }
  scope :sort_by_description_length, -> { order('LENGTH(description) DESC') }
  scope :sort_by_users_email, -> { joins(:user).order('users.email') }

  scope :order_list, ->(order_name) {
    method = order_name.presence_in(%w[sort_by_title sort_by_description_length sort_by_users_email])
    method ? send(order_name.to_sym) : order(created_at: :desc)
  }

  self.per_page = 5
end
