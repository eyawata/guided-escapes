Rails.application.routes.draw do
  devise_for :users
  root to: "experiences#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :experiences, only: [:index, :show] do
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [:index]
end
