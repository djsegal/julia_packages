Rails.application.routes.draw do

  resources :categories
  resources :categories, path: "c", as: "cats"

  resources :packages
  resources :packages, path: "p", as: "pkgs"

  resource :trending, controller: "trending"
  root to: 'trending#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
