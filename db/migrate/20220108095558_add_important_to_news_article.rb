class AddImportantToNewsArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :news_articles, :important, :boolean, null: false, default: false
  end
end
