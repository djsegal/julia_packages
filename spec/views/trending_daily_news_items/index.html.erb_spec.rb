require 'rails_helper'

RSpec.describe "trending_daily_news_items/index", type: :view do
  before(:each) do
    assign(:trending_daily_news_items, [
      TrendingDailyNewsItem.create!(),
      TrendingDailyNewsItem.create!()
    ])
  end

  it "renders a list of trending_daily_news_items" do
    render
  end
end
