Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :experiences, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:create]
    resources :reviews, only: [:index, :new, :create]
  end

  resources :reviews, only: [:show, :edit, :update, :destroy]
  resources :bookings, only: [:index]
end
