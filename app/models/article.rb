# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user, optional: true
  validates :user_id, presence: true
  validates_uniqueness_of :title, scope: :user_id

  scope :accepted, -> { where(accepted: true) }
end
