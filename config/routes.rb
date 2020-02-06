# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :update
      resources :articles, only: :index
    end
  end
  get 'hello_world', to: 'hello_world#index'
  ActiveAdmin.routes(self)
  devise_for :users
  root 'users#index', as: 'home'

  # get 'articles' => 'articles#index'

  resources :users
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
