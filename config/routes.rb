Rails.application.routes.draw do

  resources :releases
  resources :downloads
  resources :subscriptions
  resources :feeds
  resources :settings
  resources :blurbs
  resources :references
  resources :discourse_news_items
  resources :github_news_items
  resources :reddit_news_items
  resources :logs
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

  resources :news, as: :news_items, controller: :news_items

  resources :packages do
    get 'autocomplete_package_name', on: :collection
  end

  resources :users, path: 'u'
  resources :packages, path: 'p'
  resources :organizations, path: 'o'

  root 'packages#index'

  get '/*bad_route', to: 'errors#index', as: 'errors'

end
