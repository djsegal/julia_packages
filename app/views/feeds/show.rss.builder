#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title params[:id]
    xml.link "#{ feed_url(params[:id]) }.rss"
    xml.description "most recent updates on #{params[:id]}"

    @feed.news_items.first(25).each do |news_item|
      xml.item do
        xml.title news_item.name

        alt_description = "view link for more detail"
        if Package.custom_exists? news_item.name
          package = Package.custom_find news_item.name
          link = package.url
          description = package.description || alt_description
        else
          link = news_item.link
          description = alt_description
        end

        xml.link link
        xml.description description
      end
    end
  end
end
