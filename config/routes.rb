# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  namespace :api do
    namespace :v1 do
      resources :users, only: :update
      resources :articles, only: :index
    end
  end
  get 'hello_world', to: 'hello_world#index'
  ActiveAdmin.routes(self)
  root 'users#index', as: 'home'

  resources :articles
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
