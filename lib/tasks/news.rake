namespace :news do

  @news_item_types = %w[ reddit github discourse ]

  desc "make news items"
  task make: :environment do
    bar = make_progress_bar @news_item_types.count

    @news_item_types.each do |news_item_type|
      bar.inc

      news_item_class = "#{news_item_type}_news_item".classify.constantize
      news_items = YAML.load_file("#{@news_directory}/#{news_item_type}.yml")

      news_feed = Feed.create! name: news_item_type
      news_items.each do |news_item|
        news_feed.news_items << news_item_class.create!(news_item)
      end
    end

    bar.finished
  end

  desc "get all news items"
  task get_all: :environment do
    @news_item_types.each do |news_item_type|
      Rake::Task["news:#{news_item_type}"].invoke
    end
  end

  desc "get reddit news"
  task reddit: :environment do
    news_items = []

    r = Redd.it(:script, ENV['REDDIT_CLIENT_ID'], ENV['REDDIT_SECRET'], "https://juliaobserver.com/")
    r.authorize!

    hot = r.get_hot("julia")

    bar = make_progress_bar hot.count

    hot.each do |link|
      bar.inc

      next if link.stickied and \
        Time.at(link.created_utc).to_datetime < 1.month.ago

      item_link = "https://www.reddit.com/#{link.permalink}"

      is_self_post = ( link.domain == "self.Julia" )

      if is_self_post
        target_type = 'Blurb'
        target_hash = {
          cargo: link.selftext_html
        }
      else
        target_type = 'Reference'
        target_hash = {
          link: link.url
        }
      end

      news_items << {
        name: link.title,
        link: item_link,
        target_type: target_type,
        target_attributes: target_hash
      }
    end

    FileUtils.mkdir_p(@news_directory) \
      unless File.directory? @news_directory

    File.open("#{@news_directory}/raw_reddit.yml", 'w') do |h|
       h.write hot.to_yaml
    end

    File.open("#{@news_directory}/reddit.yml", 'w') do |h|
       h.write news_items.to_yaml
    end

    bar.finished
  end

  desc "get github prs"
  task github: :environment do
    news_items = []

    prs_url = "#{ @github_api_url }/search/issues?q=register"
    prs_url += "+in:title+repo:JuliaLang/METADATA.jl"
    prs_url += "+type:pr+is:merged&sort=updated"

    prs = hit_url(prs_url)['items']

    bar = make_progress_bar prs.count

    prs.each do |pr|
      bar.inc

      name = pr['title'][/(?<=\W)?\w*(?=.jl)/]

      unless name.present?
        pr_diff = hit_url pr['pull_request']['diff_url']
        name = pr_diff[/(?<=\/)\w*(?=\/url)/]
      end

      next if news_items.any? { |i| i[:name] == name }

      news_items << {
        name: name,
        link: pr['html_url'],
        target_type: 'Package'
      }
    end

    FileUtils.mkdir_p(@news_directory) \
      unless File.directory? @news_directory

    File.open("#{@news_directory}/raw_github.yml", 'w') do |h|
       h.write prs.to_yaml
    end

    File.open("#{@news_directory}/github.yml", 'w') do |h|
       h.write news_items.to_yaml
    end

    bar.finished
  end

  desc "get discourse prs"
  task discourse: :environment do
    news_items = []

    client = DiscourseApi::Client.new("http://discourse.julialang.org")
    client.api_key = ENV['DISCOURSE_API_KEY']
    client.api_username = ENV['DISCOURSE_API_USERNAME']

    posts = []

    client.categories.each do |category|
      posts += \
        client.category_latest_topics \
        category_slug: category['slug']
    end

    posts.uniq!
    posts.sort_by! { |t| t['bumped_at'] }
    posts.reverse!

    posts_count = posts.count
    max_posts_count = 60

    posts_count = max_posts_count \
      if posts_count > max_posts_count

    bar = make_progress_bar posts_count

    posts.first(max_posts_count).each do |post|
      bar.inc

      post_html = \
        client.topic(post['id'])['post_stream']['posts'].first['cooked']

      item_link = "https://discourse.julialang.org/t/#{post['slug']}"

      news_items << {
        name: post['title'],
        link: item_link,
        target_type: 'Blurb',
        target_attributes: {
          cargo: post_html
        }
      }
    end

    FileUtils.mkdir_p(@news_directory) \
      unless File.directory? @news_directory

    File.open("#{@news_directory}/raw_discourse.yml", 'w') do |h|
       h.write posts.to_yaml
    end

    File.open("#{@news_directory}/discourse.yml", 'w') do |h|
       h.write news_items.to_yaml
    end

    bar.finished
  end

end
