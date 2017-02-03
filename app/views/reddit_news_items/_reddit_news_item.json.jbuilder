json.extract! reddit_news_item, :id, :created_at, :updated_at
json.url reddit_news_item_url(reddit_news_item, format: :json)