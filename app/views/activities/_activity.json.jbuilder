json.extract! activity, :id, :commits, :package_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)