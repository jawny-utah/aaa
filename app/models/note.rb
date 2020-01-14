class Note < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true
end
