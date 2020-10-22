Rails.application.routes.draw do
  get 'friends', to: 'friends#index'
  resources :friend_requests
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#index'
end
