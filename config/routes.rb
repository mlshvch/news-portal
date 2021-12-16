Rails.application.routes.draw do
  root 'news_articles#index'

  resources :news_articles
end
