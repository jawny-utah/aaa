Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users
  root "users#index", as: "home"

  get 'edit' => 'users#edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
