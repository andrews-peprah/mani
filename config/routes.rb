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

  resources :admins
  resources :clients, only: [:index]

  namespace :clients do
    resources :customers
    resources :hierarchies
    resources :reports
    resources :transactions
  end
  
end
