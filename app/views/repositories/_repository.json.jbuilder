json.extract! repository, :id, :package_id, :url, :created_at, :updated_at
json.url repository_url(repository, format: :json)