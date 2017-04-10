Rails.application.routes.draw do

  resources :dependencies
  resources :logs

  root 'errors#pardon'
  get '/*any_route', to: 'errors#pardon', as: 'pardon'

  resources :searches, path: 's'

  resources :models
  resources :packages
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
  resources :activities
  resources :batches
  resources :infos
  resources :profiles
  resources :labels
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

  resources :searches do
    get 'autocomplete', on: :collection
  end

  resources :users, path: 'u'
  resources :packages, path: 'p'
  resources :organizations, path: 'o'

  resources :statics, only: [], path: '' do
    collection do
      get 'about'
    end
  end

  root 'packages#index'

  get '/*bad_route', to: 'errors#index', as: 'errors'

end
