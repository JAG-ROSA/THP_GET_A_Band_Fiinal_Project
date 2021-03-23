Rails.application.routes.draw do
  mount ForestLiana::Engine => "/forest"
  devise_for :users, path: "users", controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :artists, path: "artists", controllers: { sessions: "artists/sessions", registrations: "artists/registrations" }
  resources :artists do
    resources :bookings
    resources :avatars, only: [:create, :destroy]
    resources :pictures, only: [:create, :destroy]
    resources :availabilities
  end
  resources :users, only: [:create, :edit, :show, :update, :destroy]
  resources :conversations, only: [:index, :create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  

  root 'static_pages#index'

  # Routes Stripe Checkout
  resources :checkout, only: [:create, :index]

end
