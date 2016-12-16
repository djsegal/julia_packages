json.extract! counter, :id, :fork, :stargazer, :watcher, :subscriber, :open_issue, :package_id, :created_at, :updated_at
json.url counter_url(counter, format: :json)