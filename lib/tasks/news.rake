namespace :news do

  @news_item_types = %w[ reddit github discourse stack_overflow ]

  desc "make news items"
  task make: :environment do
    bar = make_progress_bar @news_item_types.count

    bad_files = []

    @news_item_types.each do |news_item_type|
      bar.inc

      news_item_class = "#{news_item_type}_news_item".classify.constantize

      cur_file = "#{@news_directory}/#{news_item_type}.yml"

      begin
        news_items = YAML.load_file(cur_file)
      rescue
        bad_files << cur_file
        next
      end

      news_feed = Feed.create! name: news_item_type
      news_items.each do |news_item|
        news_feed.news_items << news_item_class.create!(news_item)
      end
    end

    bar.finished

    return if bad_files.empty?

    mail_param_list = [
      "Bad News", "files => #{bad_files.inspect}".to_yaml
    ]

    if Rails.env.production?
      DebugLogMailer.log_email(*mail_param_list).deliver_later
    else
      DebugLogMailer.log_email(*mail_param_list).deliver_now
    end
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

    prs = blind_hit_url(prs_url)['items']

    bar = make_progress_bar prs.count

    prs.each do |pr|
      bar.inc

      cur_name = pr['title'][/(?<=\W)?\w*(?=.jl)/]

      unless cur_name.present?
        begin
          pr_diff = blind_hit_url pr['pull_request']['diff_url']
        rescue
          CronLogMailer.log_email(
            "News", pr.to_yaml
          ).deliver_now

          next
        end

        if pr_diff.parsed_response == "Sorry, this diff is unavailable."
          cur_name = pr['body'][/(?<=\W)?\w*(?=.jl.git)/]
        else
          cur_name = pr_diff[/(?<=\/)\w*(?=\/url)/]
        end
      end

      unless cur_name.present?
        CronLogMailer.log_email(
          "News", pr.to_yaml
        ).deliver_now

        next
      end

      next if news_items.any? { |i| i[:name] == cur_name }

      news_items << {
        name: cur_name,
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
    api_requests = 0

    news_items = []

    client = DiscourseApi::Client.new("http://discourse.julialang.org")
    client.api_key = ENV['DISCOURSE_API_KEY']
    client.api_username = ENV['DISCOURSE_API_USERNAME']

    posts = []

    client.categories.each do |category|
      posts += \
        client.category_latest_topics \
        category_slug: category['slug']

      api_requests += 1
      sleep(1.minute) if (api_requests % 10).zero?
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

      api_requests += 1
      sleep(1.minute) if (api_requests % 10).zero?
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

  desc "get stack overflow questions"
  task stack_overflow: :environment do
    news_items = []

    stack_overflow_page = "https://api.stackexchange.com/2.2/questions"
    stack_overflow_page += "?order=desc&sort=creation&tagged=julia"
    stack_overflow_page += "&site=stackoverflow&filter=!9YdnSIN18"

    questions = HTTParty.get(stack_overflow_page)["items"]

    bar = make_progress_bar questions.count

    questions.each do |question|
      bar.inc

      news_items << {
        name: question['title'],
        link: question['link'],
        target_type: 'Blurb',
        target_attributes: {
          cargo: question['body']
        }
      }
    end

    FileUtils.mkdir_p(@news_directory) \
      unless File.directory? @news_directory

    File.open("#{@news_directory}/raw_stack_overflow.yml", 'w') do |h|
       h.write questions.to_yaml
    end

    File.open("#{@news_directory}/stack_overflow.yml", 'w') do |h|
       h.write news_items.to_yaml
    end

    bar.finished
  end

end
