@downloads_directory = 'tmp/downloads'
@metadata_directory = 'tmp/METADATA.jl'
@trending_directory = 'tmp/trending'
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
