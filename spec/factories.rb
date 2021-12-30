# frozen_string_literal: true

# user.rb

FactoryBot.define do
  factory :user do
    email { 'abcdef@example.com' }
    password { 'rubyonrails' }
    password_confirmation { 'rubyonrails' }
    confirmed_at { Time.now }
  end
end
