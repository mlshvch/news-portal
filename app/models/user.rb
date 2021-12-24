# frozen_string_literal: true

class User < ApplicationRecord
  has_many :news_article

  enum role: %i[reader reporter editor admin]

  def set_default_role
    self.role ||= :reader
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
