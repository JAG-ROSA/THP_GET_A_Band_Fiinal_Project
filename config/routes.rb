Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, path: 'users'
  devise_for :artists, path: 'artists'
  resources :artists
  resources :users

  root 'static_pages#index'

end
