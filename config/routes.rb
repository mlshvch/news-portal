# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'news_articles#index'

  resources :news_articles
end
