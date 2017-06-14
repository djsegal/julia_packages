require 'rails_helper'

RSpec.describe "trending_weekly_news_items/show", type: :view do
  before(:each) do
    @trending_weekly_news_item = assign(:trending_weekly_news_item, TrendingWeeklyNewsItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
