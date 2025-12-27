# frozen_string_literal: true

Rails.application.routes.draw do
  # Define the root path
  resources :books, only: %i[index show create update]

  # マジックリンク
  resources :magic_links, only: %i[show create]

  # セッションAPI
  resource :session, only: %i[show destroy]
end
