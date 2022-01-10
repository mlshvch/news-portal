# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'news_articles#index'

  get 'feeds/rss', to: 'feeds#rss_index', format: 'rss'

  resources :news_articles do
    resources :comments
    member do
      put 'approve', to: 'news_articles#approve_news', as: :approve
      put 'publish', to: 'news_articles#publish_news', as: :publish
      put 'retract', to: 'news_articles#retract_news', as: :retract
    end
  end
end
