# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user, optional: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :user_id }

  scope :accepted, -> { where(accepted: true) }
end
