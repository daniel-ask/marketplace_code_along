Rails.application.routes.draw do
  root 'listings#index'
  devise_for :users
  resources :listings
  get '/purchases/success', to: 'purchases#success'
  post '/purchases/webhook', to: 'purchases#webhook'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
