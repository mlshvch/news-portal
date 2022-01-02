# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_many :news_articles

  has_many :news_articles

  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
