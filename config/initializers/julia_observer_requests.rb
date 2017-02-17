def blind_hit_url url
  url_response = HTTParty.get url, \
    query: @client_info,
    headers: @url_headers

  validate_response url, url_response
  url_response
end

def check_and_hit_url url
  hit_and_check = []
  hit_and_check << is_new_response?(url)

  hit_and_check.unshift hit_url(url)
  hit_and_check
end

def is_new_response? url
  return true \
    unless Batch.active_marker_date.present?

  url_response = HTTParty.get url, \
    query: @client_info, \
    headers: @url_headers.merge({
      "If-Modified-Since" => Batch.active_marker_date.rfc822
    })

  validate_response url, url_response
  return false if url_response.code == 304

  Rails.cache.write url, url_response.to_yaml
  true
end

def hit_url url, skip_cache=false, expires_in=nil
  unless skip_cache
    cached_response = Rails.cache.read url

    if cached_response.present?
      url_response = YAML.load cached_response
      validate_response url, url_response
      return url_response
    end
  end

  url_response = blind_hit_url url

  Rails.cache.write url, url_response.to_yaml, \
    expires_in: expires_in

  url_response
end

def validate_response url, url_response
  return if url_response.respond_to? :to_ary
  return unless url_response["message"].present?

  throttling_error = "API rate limit exceeded"
  raise "#{throttling_error} for: #{url}" \
    if url_response["message"].starts_with? throttling_error
end
