class User < ApplicationRecord
  has_many :news_article, class_name: "news_article", foreign_key: "news_article_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
