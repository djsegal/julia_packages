Rails.application.routes.draw do
  resources :categories
  resources :daters
  resources :counters
  resources :versions
  resources :repositories
  resources :packages

  root 'home#index'
  get 'home/index'
end
