Rails.application.routes.draw do
  root to: 'homes#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'sign_up', to: 'users#new'
  resources :reviews
  resources :users, only: %i[ create show ]
  resource :profile, only: %i[ show edit update ] do
    resource :mycat, only: %i[ new create show edit update], module: 'profiles'
  end
end
