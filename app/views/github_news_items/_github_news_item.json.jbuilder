json.extract! github_news_item, :id, :created_at, :updated_at
json.url github_news_item_url(github_news_item, format: :json)