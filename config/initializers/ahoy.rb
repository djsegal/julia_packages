class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore

end

Ahoy.geocode = :async
Ahoy.track_visits_immediately = true
Ahoy.cookie_domain = :all
Ahoy.throttle_limit = 100
Ahoy.throttle_period = 5.minutes
