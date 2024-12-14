Rails.application.routes.draw do
  devise_for :users
  
  # Root route
  root "photos#index"
  
  # Resource routes
  resources :users, only: [:index, :show, :edit, :update]
  resources :photos
  resources :comments
  resources :likes
  resources :follow_requests
end
