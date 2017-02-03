json.extract! discourse_news_item, :id, :created_at, :updated_at
json.url discourse_news_item_url(discourse_news_item, format: :json)