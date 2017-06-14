require 'rails_helper'

RSpec.describe "trending_weekly_news_items/index", type: :view do
  before(:each) do
    assign(:trending_weekly_news_items, [
      TrendingWeeklyNewsItem.create!(),
      TrendingWeeklyNewsItem.create!()
    ])
  end

  it "renders a list of trending_weekly_news_items" do
    render
  end
end
