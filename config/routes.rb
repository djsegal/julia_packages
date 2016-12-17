Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  resources :daters
  resources :counters
  resources :versions
  resources :repositories
  resources :packages

end
