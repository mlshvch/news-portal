# frozen_string_literal: true

class AddAccessRightsToNewsArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :news_articles, :access_rights, :integer, null: false, default: 0
  end
end
