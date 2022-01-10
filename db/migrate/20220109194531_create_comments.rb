class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :user, index: true, null: false
      t.references :news_article, index: true, null: false
      t.timestamps
    end
  end
end
