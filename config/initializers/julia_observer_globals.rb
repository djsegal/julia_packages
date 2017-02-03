@metadata_directory = 'tmp/METADATA.jl'
@github_directory = 'tmp/github'
@news_directory = 'tmp/news'

@github_api_url = "https://api.github.com"

@client_info = {
  access_token: ENV['ACCESS_TOKEN'],
  client_id: ENV['CLIENT_ID'],
  client_secret: ENV['CLIENT_SECRET']
}

@client_info.delete_if { |k, v| v.nil? }

def hit_url url
  HTTParty.get url, query: @client_info
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
  return StubbedBar.new \
    if Rails.env.production?

  RakeProgressbar.new bar_count
end
