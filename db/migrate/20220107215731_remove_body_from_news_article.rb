# frozen_string_literal: true

class RemoveBodyFromNewsArticle < ActiveRecord::Migration[6.1]
  def change
    remove_column :news_articles, :body
  end
end
