Rails.application.routes.draw do

  resources :analytics, only: [:index]

  resources :users, only: [:index, :show]
  resources :users, path: "u", as: "usrs", only: [:index, :show]

  resources :categories, only: [:index, :show]
  resources :categories, path: "c", as: "cats", only: [:index, :show]

  resources :packages, only: [:index, :show]
  resources :packages, path: "p", as: "pkgs", only: [:index, :show]

  resource :trending, controller: "trending", only: [:show]
  root to: 'trending#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
