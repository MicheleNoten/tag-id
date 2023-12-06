Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :scans

  resources :products do
    resources :bookmarks, only: [:create]
    resources :wardrobes, only: [:create]
  end

  resources :bookmarks, only: [:index, :destroy]
  resources :wardrobes, only: [:index, :update, :destroy]
  resources :product_fabrics, only: [:show]

  get "profile", to: "pages#profile", as: :profile
  get "score", to: "pages#score", as: :score
  get "climate", to: "pages#climate", as: :climate
  get "water", to: "pages#water", as: :water
  get "waste", to: "pages#waste", as: :waste
  get "land", to: "pages#land", as: :land
  get "integrity", to: "pages#integrity", as: :integrity
  get "human_rights", to: "pages#human_rights", as: :human_rights
  get "chemistry", to: "pages#chemistry", as: :chemistry
  get "biodiversity", to: "pages#biodiversity", as: :biodiversity
  get "animal_welfare", to: "pages#animal_welfare", as: :animal_welfare

  get 'fibres/seed', to: 'fibres#seed'

  get "up" => "rails/health#show", as: :rails_health_check
end
