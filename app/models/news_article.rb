# frozen_string_literal: true

class NewsArticle < ApplicationRecord
  resourcify
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  enum state: %i[not_active active published archived]

  include AASM

  aasm column: :state, enum: true do
    state :not_active, initial: true
    state :active, :published, :archived

    event :approve do
      transitions from: :not_active, to: :active
    end

    event :publish do
      transitions from: :active, to: :published
    end

    event :archive do
      transitions from: :published, to: :archived
    end
  end
end
