Rails.application.routes.draw do
  root 'home#index'
  
  mount ActionCable.server => '/cable'
  
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  
  devise_scope :user do
    post 'guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
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
  
  resources :some, only: [:index, :show, :edit, :update, :destroy]
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
      collection do
       get 'search'
       get 'genre_search'
       get 'tag_search'
      end
  end
  
  resources :groups do
    resources :members
    resources :events, only: [:create]
    resources :group_users, only: [:create]
    resources :messages, only: [:create]
    delete 'remove_member/:user_id', to: 'groups#remove_member', as: 'remove_member'
  end
  
  resources :events
  
  resources :chats, only: [:create]
  resources :chat_rooms, only: [:index, :show]
  #root to: 'posts#index'
  
  get 'search', to: 'posts#search'
  get 'tag_search', to: 'posts#tag_search'
end
