Rails.application.routes.draw do
  get     'sessions/new'
  root    'static_pages#home'

  get     '/help',      to: 'static_pages#help'
  get     '/about',     to: 'static_pages#about'

  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'

  get     '/signup',    to: 'users#new'

  resources :users, except: :new do
    member do
      get 'following', 'followers'
    end
  end

  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :votes,         only: [:create, :destroy]
end
