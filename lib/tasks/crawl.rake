namespace :crawl do

  @durations_list = %w[ daily weekly monthly ]

  desc "make feed with crawled trending data"
  task feed: :environment do
    bar = make_progress_bar @durations_list.count

    @durations_list.each do |cur_duration|
      bar.inc

      trending_item_class = "trending_#{cur_duration}_news_item".classify.constantize
      trending_items = YAML.load_file("#{@trending_directory}/#{cur_duration}.yml")

      trending_feed = Feed.create! name: "trending_#{cur_duration}"
      trending_items.each do |trending_item|
        trending_feed.news_items << trending_item_class.create!(trending_item)
      end
    end

    bar.finished
  end

  desc "crawl github for trending"
  task github: :environment do

    @durations_list.each_with_index do |cur_duration, cur_index|

      sleep(15.seconds) unless cur_index.zero?

      trending_items = []

      github_page = "https://github.com/trending/julia?since=#{cur_duration}"

      hit_page = HTTParty.get(github_page)

      parsed_page = Nokogiri::HTML(hit_page)

      package_list = parsed_page.css('ol.repo-list li')

      package_dict = {}

      package_list.each do |cur_item|

        cur_key = cur_item.css("h3 a").first.attributes['href'].value[1..-1]

        if cur_item.css("p").first.present?
          cur_value = cur_item.css("p").first.children.to_s.strip
        else
          cur_value = ""
        end

        package_dict[cur_key] = cur_value

      end

      bar = make_progress_bar package_dict.keys.count

      package_dict.each do |cur_key, cur_value|
        bar.inc

        _, package_name = cur_key.split '/'

        package_name.gsub! '.jl', ''

        next if package_name.downcase == 'julia'

        trending_items << {
          name: package_name,
          link: "https://github.com/#{cur_key}",
          target_type: 'Blurb',
          target_attributes: {
            cargo: cur_value
          }
        }

      end

      FileUtils.mkdir_p(@trending_directory) \
        unless File.directory? @trending_directory

      File.open("#{@trending_directory}/raw_#{cur_duration}.yml", 'w') do |h|
         h.write package_list.to_yaml
      end

      File.open("#{@trending_directory}/#{cur_duration}.yml", 'w') do |h|
         h.write trending_items.to_yaml
      end

    end

  end

end
