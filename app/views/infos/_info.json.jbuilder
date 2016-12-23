json.extract! info, :id, :repos, :followers, :following, :created, :owner_id, :owner_type, :created_at, :updated_at
json.url info_url(info, format: :json)