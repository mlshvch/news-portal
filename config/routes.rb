Rails.application.routes.draw do
  devise_for :users
  resources :users
  root 'news_articles#index'

  resources :news_articles
end
