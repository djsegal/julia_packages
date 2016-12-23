json.extract! profile, :id, :nickname, :company, :blog, :location, :bio, :owner_id, :owner_type, :created_at, :updated_at
json.url profile_url(profile, format: :json)