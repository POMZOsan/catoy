Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root to: 'homes#top'
  get 'privacy_policy', to: 'homes#privacy_policy'
  get 'kiyaku', to: 'homes#kiyaku'

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
  resource :profile, only: %i[ show edit update destroy ] do
    resource :mycat, only: %i[ new create show edit update], module: 'profiles'
  end

  get 'ranking', to: 'rankings#index'

  namespace :api do
    resources :reviews, only: %i[ edit create update ]
    resources :comments, only: %i[ index create destroy ]
    get 'cainz', to: 'cainz#index'
    get 'rakuten', to: 'rakuten#index'
    get 'active_cat_ranking', to: 'ranking#active'
    get 'gentle_cat_ranking', to: 'ranking#gentle'
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

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  
  resources :password_resets, only: %i[ new create edit update ]

  get '/sitemap', to: redirect("https://#{Rails.application.credentials.dig(:aws, :sitemap_bucket)}.s3.#{Rails.application.credentials.dig(:aws, :region)}.amazonaws.com/sitemap.xml.gz")
end
