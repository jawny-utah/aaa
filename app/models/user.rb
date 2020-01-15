# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  enum role: %i[admin guest]
  has_many :articles
  has_many :notes
  before_validation :create_user_name, if: -> { new_record? }
  validates :nickname, uniqueness: true

  extend FriendlyId
  friendly_id :nickname, use: %i[slugged finders]

  def confirmation_required?
    false
  end

  def name
    email
  end

  def create_user_name
    self.nickname = Faker::Name.first_name
  end
end
