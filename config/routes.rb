Rails.application.routes.draw do
  namespace :search do
    resources :spaces
    root to: "spaces#index"
  end

  root "venues#index"
  devise_for :admins
  devise_for :users

  resources :bookings
  resources :venues do
    resources :venue_amenities
    resources :spaces
    resources :amenities do
      resources :service_charges
    end
  end
end
