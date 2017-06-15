json.extract! stack_overflow_news_item, :id, :created_at, :updated_at
json.url stack_overflow_news_item_url(stack_overflow_news_item, format: :json)