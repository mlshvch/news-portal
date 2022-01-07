# frozen_string_literal: true

class AddDescriptionToNewsArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :news_articles, :description, :text, nil: false
  end
end
