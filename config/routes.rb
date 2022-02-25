Rails.application.routes.draw do
  resources :genres
  root to: 'movies#index'
  get 'movies/filter/:filter', to: 'movies#index', as: :filtered_movies
  resources :movies do 
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end
  
  resources :users 
  get 'signup', to: 'users#new'

  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'

  
 
end
