json.extract! contribution, :id, :user_id, :package_id, :created_at, :updated_at
json.url contribution_url(contribution, format: :json)