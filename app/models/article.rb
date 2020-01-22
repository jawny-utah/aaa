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

  scope :accepted, -> { where(accepted: true) }
  self.per_page = 5
end
