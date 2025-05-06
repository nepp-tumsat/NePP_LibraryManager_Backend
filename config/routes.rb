Rails.application.routes.draw do
  # Define the root path
  root 'hello#index'
  resources :books, only: [:index]
end
