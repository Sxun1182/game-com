Rails.application.routes.draw do
  root 'home#index'
  
  mount ActionCable.server => '/cable'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  namespace :admin do
    resources :genres, only: [:index, :new, :create]
  end
  
  resources :users, only: [:show] do
    member do
      get :following, :followers
      post 'follow', to: 'relationships#create'
      delete 'unfollow', to: 'relationships#destroy'
    end
    resources :posts, only: [:index]
  end
  
  resources :posts do
    resources :comments, only: [:create]
    resource :likes, only: [:create, :destroy]
      collection do
       get 'search'
       get 'genre_search'
       get 'tag_search'
      end
    
  end
  
  resources :chats, only: [:create]
  resources :chat_rooms, only: [:index, :show]
  
  resources :groups do
    resources :group_users, only: [:create]
    resources :events, only: [:create]
    resources :messages, only: [:create]
  end
  
  #root to: 'posts#index'
  
  get 'search', to: 'posts#search'
  get 'tag_search', to: 'posts#tag_search'
end
