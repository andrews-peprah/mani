Rails.application.routes.draw do
  devise_for :clients
  devise_for :admins
  use_doorkeeper
  
  # Mounting API
  mount API => '/'

  post 'api/v1/login' => 'doorkeeper/tokens#create'

  resources :base
  # Root path base controller
  root controller: :base, action: :index

  resources :admins, only: [:index]
  namespace :admins do
    resources :accounts
    resources :hierarchies
    resources :members
    resources :profiles
    resources :settings
    resources :transactions
  end

  resources :clients, only: [:index]
  namespace :clients do
    resources :customers
    resources :hierarchies
    resources :reports
    resources :transactions
  end
  
end
