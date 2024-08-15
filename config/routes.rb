Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

   resources :experiences do
    resources :bookings, only: [:create]
    resources :reviews, only: [:index, :new, :create]
  end

  resources :reviews, only: [:show, :edit, :update, :destroy]
  resources :bookings, only: [:index]
end
