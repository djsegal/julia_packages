Rails.application.routes.draw do

  resources :activities
  resources :batches
  resources :infos
  resources :profiles
  resources :labels
  resources :readmes
  resources :organizations
  resources :contributions
  resources :users
  resources :dummies
  resources :categories
  resources :daters
  resources :counters
  resources :versions
  resources :repositories

  resources :packages do
    get 'autocomplete_package_name', on: :collection
  end

  root 'packages#index'

end
