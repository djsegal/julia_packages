Rails.application.routes.draw do
  resources :packages
  resources :packages, path: "p", as: "pkgs"

  root to: 'packages#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
