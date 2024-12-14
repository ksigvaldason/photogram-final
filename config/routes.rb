Rails.application.routes.draw do
  devise_for :users
  root "photos#index"
  
  resources :users, only: [:index, :show], param: :username
  resources :photos do
    resources :likes, only: [:create, :destroy]
  end
  resources :comments
  resources :follow_requests, only: [:create, :destroy]
end
