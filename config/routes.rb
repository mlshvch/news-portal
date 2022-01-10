# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'news_articles#index'

  resources :news_articles

  resources :news_articles do
    member do
      put 'approve', to: 'news_articles#approve_news', as: :approve
      put 'publish', to: 'news_articles#publish_news', as: :publish
      put 'retract', to: 'news_articles#retract_news', as: :retract
    end
  end
end
