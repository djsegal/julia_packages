@metadata_directory = 'tmp/METADATA.jl'
@github_directory = 'tmp/github'
@scour_directory = 'tmp/scour'
@news_directory = 'tmp/news'

@github_api_url = "https://api.github.com"

@client_info = {
  access_token: ENV['ACCESS_TOKEN'],
  client_id: ENV['CLIENT_ID'],
  client_secret: ENV['CLIENT_SECRET']
}

@client_info.delete_if { |k, v| v.nil? }

@url_headers = { "User-Agent" => "djsegal" }

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

def blind_hit_url url
  url_response = HTTParty.get url, \
    query: @client_info,
    headers: @url_headers

  validate_response url, url_response
  url_response
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

def check_and_hit_url url
  hit_and_check = []
  hit_and_check << is_new_response?(url)

  hit_and_check.unshift hit_url(url)
  hit_and_check
end

def validate_response url, url_response
  return if url_response.respond_to? :to_ary
  return unless url_response["message"].present?

  throttling_error = "API rate limit exceeded"
  raise "#{throttling_error} for: #{url}" \
    if url_response["message"].starts_with? throttling_error
end

class StubbedBar
  attr_accessor :bar

  def initialize
    bar_object = super
    self.bar = RakeProgressbar.new(2)
    self.bar.inc
    puts ""

    bar_object
  end

  def inc
    return
  end

  def finished
    self.bar.finished
    puts ""
  end
end

def make_progress_bar bar_count
  use_stubbed_bar = Rails.env.production?
  use_stubbed_bar &&= ( ENV['VERBOSE'] != 'true' )

  return StubbedBar.new \
    if use_stubbed_bar

  RakeProgressbar.new bar_count
end
