Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check  
  resources :users
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
