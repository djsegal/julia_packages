Rails.application.routes.draw do

  resource :trending
  resources :dependencies
  resources :logs

  # root 'errors#pardon'
  # get '/*any_route', to: 'errors#pardon', as: 'pardon'

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
  resources :trending_weekly_news_items
  resources :trending_daily_news_items
  resources :trending_monthly_news_items
  resources :stack_overflow_news_items
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

  resource :trending, path: 't'

  resources :users, path: 'u'
  resources :packages, path: 'p'
  resources :organizations, path: 'o'

  resources :statics, only: [], path: '' do
    collection do
      get 'about'
    end
  end

  root 'trendings#index'

  get '/*bad_route', to: 'errors#index', as: 'errors'

end
