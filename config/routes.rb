Rails.application.routes.draw do
  devise_for :users
  devise_for :artists
  resources :artists
  resources :users

  root 'static_pages#index'

end
