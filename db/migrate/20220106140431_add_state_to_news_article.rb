class AddStateToNewsArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :news_articles, :state, :integer, null: false, default: 0
  end
end
