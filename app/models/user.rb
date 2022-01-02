# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_many :news_articles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_initialize :assign_default_role

  private

  def assign_default_role
    add_role(:reader)
  end
end
