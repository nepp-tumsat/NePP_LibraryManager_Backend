# frozen_string_literal: true

Rails.application.routes.draw do
  # Define the root path
  resources :books, only: %i[index show create update]
end
