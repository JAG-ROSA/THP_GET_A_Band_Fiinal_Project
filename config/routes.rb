Rails.application.routes.draw do
  devise_for :artists
  resources :artists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  resources :users

  root 'static_pages#index'

end
