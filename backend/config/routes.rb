# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'root#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users do
    resources :posts
    resources :friendships, only: %i[index create destroy] do
      delete :destroy, on: :collection
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
