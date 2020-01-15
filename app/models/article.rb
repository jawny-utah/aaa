class Article < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates_uniqueness_of :title, scope: :user_id

  scope :accepted, -> { where(accepted: true) }
end
