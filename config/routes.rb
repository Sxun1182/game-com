Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :users, only: [:show] do
    resources :posts, only: [:index]
  end
  resources :posts do
    resources :comments, only: [:create]
    resource :likes, only: [:create, :destroy]
  end
  resources :chats, only: [:create]
  root to: 'posts#index'
end
