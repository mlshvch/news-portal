# frozen_string_literal: true

class NewsArticle < ApplicationRecord
  resourcify
  belongs_to :user
  validates :title, presence: true
  has_one_attached :main_image, dependent: :destroy
  validates :main_image, presence: true
  has_rich_text :body
  validates :body, presence: true, length: { minimum: 10 }

  enum state: %i[not_active active published archived]
  enum access_rights: %i[only_for_registered title_and_annotation only_title avaliable_for_everyone]

  include AASM
  include NewsArticleMethods

  aasm timestamps: true, column: :state, enum: true do
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
