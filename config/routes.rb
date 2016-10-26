Rails.application.routes.draw do
  namespace :search do
    resources :spaces
    root to: "spaces#index"
  end

  root "venues#index"
  devise_for :admins
  devise_for :users

  resources :store_bookings

  resources :bookings
  resources :venues do
    resources :venue_amenities
    resources :amenities do
      resources :service_charges
    end
  end
end
