Rails.application.routes.draw do
  root to: 'homes#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'sign_up', to: 'users#new'
  resources :users, only: %i[ create ]
  resource :profile, only: %i[ show edit update ]
end
