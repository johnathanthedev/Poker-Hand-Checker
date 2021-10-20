# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :poker_hand
  get '/', to: 'poker_hand#index'
  post '/', to: 'poker_hand#submit_hand'
end
