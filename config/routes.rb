# frozen_string_literal: true

Rails.application.routes.draw do
  # Define the root path
  root 'hello#index'
  resources :books, only: %i[index show create update]
end
