json.extract! news_article, :id, :title, :body, :created_at, :updated_at
json.url news_article_url(news_article, format: :json)
