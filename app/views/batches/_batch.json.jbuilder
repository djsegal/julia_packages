json.extract! batch, :id, :marker, :item_id, :item_type, :created_at, :updated_at
json.url batch_url(batch, format: :json)