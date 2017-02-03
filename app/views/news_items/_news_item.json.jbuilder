json.extract! news_item, :id, :name, :target_id, :target_type, :link, :created_at, :updated_at
json.url news_item_url(news_item, format: :json)