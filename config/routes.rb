# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  root 'news_articles#index'

  resources :news_articles
end
