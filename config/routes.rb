Rails.application.routes.draw do

  resources :dummies
  resources :categories
  resources :daters
  resources :counters
  resources :versions
  resources :repositories

  resources :packages do
    get 'autocomplete_package_name', on: :collection
  end

  get 'home/index'

  root 'home#index'
end
