# frozen_string_literal: true

class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  enum role: %i[admin guest]
  has_many :articles, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_one :setting, dependent: :destroy
  validates :nickname, presence: true
  validates :nickname, uniqueness: { case_sensitive: false }

  extend FriendlyId
  friendly_id :nickname, use: %i[slugged finders]

  scope :accepted_articles, -> { joins(:articles).where(articles: { accepted: true }).group(:id) }
  scope :all_except, ->(user) { where.not(id: user) }

  def confirmation_required?
    false
  end

  def name
    email
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.nickname = provider_data.info.name
      user.save
    end
  end
end
