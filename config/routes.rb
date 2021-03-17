Rails.application.routes.draw do
  mount ForestLiana::Engine => "/forest"
  devise_for :users, path: "users", controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :artists, path: "artists", controllers: { sessions: "artists/sessions", registrations: "artists/registrations" }
  resources :artists do
    resources :bookings
    resources :availabilities
  end
  resources :users
  

  root "static_pages#index"
end
