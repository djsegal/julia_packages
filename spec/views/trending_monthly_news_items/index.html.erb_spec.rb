require 'rails_helper'

RSpec.describe "trending_monthly_news_items/index", type: :view do
  before(:each) do
    assign(:trending_monthly_news_items, [
      TrendingMonthlyNewsItem.create!(),
      TrendingMonthlyNewsItem.create!()
    ])
  end

  it "renders a list of trending_monthly_news_items" do
    render
  end
end
