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

  get '/send_email_confirmation/:id' => 'users#send_email_confirmation', as: 'send_email_confirmation'
  get '/email_activate/:id' => 'users#email_activate', as: 'email_activate'
  resources :articles
  resources :users
  resources :settings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
