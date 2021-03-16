Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :artists, path: 'artists'
  resources :artists
  resources :users

  root 'static_pages#index'

  # Routes Stripe Checkout
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end  
end
