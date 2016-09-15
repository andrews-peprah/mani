Rails.application.routes.draw do
  use_doorkeeper
  
  # Mounting API
  mount API => '/'

  post 'api/v1/login' => 'doorkeeper/tokens#create'

  resources :base
  # Root path base controller
  root controller: :base, action: :index
end
