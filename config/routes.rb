Rails.application.routes.draw do
  root to: 'homes#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'sign_up', to: 'users#new'
  resources :reviews, only: %i[ index new show edit destroy ] do
    get 'favourites', on: :collection
    get 'search', on: :collection
  end
  resources :favourites, only: %i[ create destroy ]
  resources :users, only: %i[ create show ]
  resource :profile, only: %i[ show edit update ] do
    resource :mycat, only: %i[ new create show edit update], module: 'profiles'
  end

  namespace :api do
    resources :reviews, only: %i[ edit create update ]
    resources :comments, only: %i[ index create destroy ]
    get 'cainz', to: 'cainz#index'
    get 'rakuten', to: 'rakuten#index'
  end

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :reviews, only: %i[ index show edit update destroy ]
    resources :users, only: %i[ index show edit update destroy ]
    resources :toys
  end
end
