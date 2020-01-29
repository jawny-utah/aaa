# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { :guest }
  end
end
