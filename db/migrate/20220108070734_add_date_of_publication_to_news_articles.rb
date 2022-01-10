# frozen_string_literal: true

class AddDateOfPublicationToNewsArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :news_articles, :published_at, :timestamp, default: nil
  end
end
