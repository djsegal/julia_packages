json.extract! subscription, :id, :feed_id, :news_item_id, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)