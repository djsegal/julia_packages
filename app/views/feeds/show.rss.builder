#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title params[:id]
    xml.link "#{ feed_url(params[:id]) }.rss"

    @feed.news_items.first(25).each do |news_item|
      xml.item do
        xml.title news_item.name
        xml.link news_item.link
      end
    end
  end
end
