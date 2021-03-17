Rails.application.routes.draw do
  mount ForestLiana::Engine => "/forest"
  devise_for :users, path: "users", controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :artists, path: "artists", controllers: { sessions: "artists/sessions", registrations: "artists/registrations" }
  resources :artists do
    resources :bookings
  end
  resources :users
  resources :availabilities

  root 'static_pages#index'

  # Routes Stripe Checkout
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end  
end
