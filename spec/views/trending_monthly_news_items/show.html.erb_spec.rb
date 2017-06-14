require 'rails_helper'

RSpec.describe "trending_monthly_news_items/show", type: :view do
  before(:each) do
    @trending_monthly_news_item = assign(:trending_monthly_news_item, TrendingMonthlyNewsItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
