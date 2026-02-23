Rails.application.routes.draw do
  root 'static_pages#home'
  
  resources :gossips do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
end