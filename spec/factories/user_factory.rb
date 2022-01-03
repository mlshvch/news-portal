# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'rubyonrails' }
    password_confirmation { 'rubyonrails' }
    confirmed_at { Time.now }
  end
end
