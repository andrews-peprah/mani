class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json

  mount Mobile::V1
  mount Web::V1
  # mount Smartwatch::V1
end