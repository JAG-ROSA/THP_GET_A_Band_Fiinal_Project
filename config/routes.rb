Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :artists, path: 'artists'
  resources :artists
  resources :users

  root 'static_pages#index'

end
