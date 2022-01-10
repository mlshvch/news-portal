class AddUserToNewsArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :news_articles, :user
    add_foreign_key :news_articles, :users
  end
end
