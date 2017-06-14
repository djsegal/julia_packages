require 'rails_helper'

RSpec.describe "trending_daily_news_items/show", type: :view do
  before(:each) do
    @trending_daily_news_item = assign(:trending_daily_news_item, TrendingDailyNewsItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
