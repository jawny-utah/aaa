# frozen_string_literal: true

class Setting < ApplicationRecord
  belongs_to :user, optional: true
  validates :header_color, presence: true
  validates :background_color, presence: true
  validates :information_color, presence: true
end
