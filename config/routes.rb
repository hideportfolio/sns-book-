# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index edit update]

  resources :books

  resource :favorites, only: %i[create destroy]
  resource :book_comments, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  get '/search', to: 'search#search'

  resource :chats, only: %i[create show]

  # get 'rooms/new' => 'chats#show', as: 'chat'

  root 'home#top'
  get 'home/about'
end
