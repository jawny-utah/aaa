# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Internet.user_name }
    description { Faker::Internet.user_name }
    accepted { true }
  end
end
