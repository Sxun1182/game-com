Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  resources :users, only: [:show] do
    resources :posts, only: [:index]
  end
  resources :posts do
    resources :comments, only: [:create]
    resource :likes, only: [:create, :destroy]
  end
  resources :chats, only: [:create]
  resources :chat_rooms, only: [:index, :show]
  
  resources :groups do
    resources :group_users, only: [:create]
    resources :events, only: [:create]
    resources :messages, only: [:create]
  end
  
  root to: 'posts#index'
  
  get 'search', to: 'posts#search'
end
