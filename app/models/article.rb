# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user, optional: true
  delegate :email, to: :user, prefix: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :user_id }
  scope :search_by_content, ->(query) {
    return if query.blank?
    where('title ILIKE:query OR description ILIKE:query', query: "%#{query}%")
  }
  after_create_commit do
    ArticleBroadcastJob.perform_later(user)
  end

  after_update_commit do
    ArticleBroadcastJob.perform_later(user)
  end

  after_destroy do
    ArticleBroadcastJob.perform_later(user)
  end

  scope :accepted, -> { where(accepted: true) }
  scope :sort_by_title, -> { order(title: :asc) }
  scope :sort_by_description_length, -> { order('LENGTH(description) DESC') }
  scope :sort_by_users_email, -> { joins(:user).order('users.email') }

  scope :order_list, ->(order_name) {
    method = order_name.presence_in(%w[title description_length users_email])
    method ? send(('sort_by_' + order_name).to_sym) : order(created_at: :desc)
  }

  self.per_page = 5
end
