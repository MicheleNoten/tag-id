Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :scans

  resources :products do
    resources :bookmarks, only: [:create]
    resources :wardrobes, only: [:create]
  end

  resources :bookmarks, only: [:index, :destroy]
  resources :wardrobes, only: [:index, :new, :create, :update, :destroy]
  resources :product_fabrics, only: [:show]

  get "profile", to: "pages#profile", as: :profile
  get "score", to: "pages#score", as: :score

  get 'fibres/seed', to: 'fibres#seed'

  get "up" => "rails/health#show", as: :rails_health_check
end
