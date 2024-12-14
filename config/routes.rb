Rails.application.routes.draw do
  devise_for :users
  root "photos#index"
  
  resources :users do
    member do
      get :liked_photos
      get :feed
      get :discover
    end
  end
  resources :photos do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create] # Add this line
  end
  resources :comments, only: [:destroy]
  resources :follow_requests, only: [:create, :destroy]
end
