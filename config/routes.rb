Rails.application.routes.draw do

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

  require 'crono/web'
  if Rails.env.production?
    Crono::Web.use Rack::Auth::Basic do |username, password|
      username == ENV["CRONO_USERNAME"] && \
        password == ENV["CRONO_PASSWORD"]
    end
  end
  mount Crono::Web, at: '/crono'

  root 'packages#index'

end
