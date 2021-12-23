# frozen_string_literal: true

class NewsArticle < ApplicationRecord
  belongs_to :user, class_name: 'user', foreign_key: 'user_id'
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
