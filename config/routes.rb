# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'city#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount API::Base, at: '/'

  resources :city, only: [:create, :update, :destroy, :forecast] do
    collection do
      get 'forecast'
    end
  end
end
