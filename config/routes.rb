Rails.application.routes.draw do
  root to: 'homes#top'

  resources :users, only: %i[ new create ]
end
