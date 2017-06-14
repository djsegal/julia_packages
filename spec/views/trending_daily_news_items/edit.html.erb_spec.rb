require 'rails_helper'

RSpec.describe "trending_daily_news_items/edit", type: :view do
  before(:each) do
    @trending_daily_news_item = assign(:trending_daily_news_item, TrendingDailyNewsItem.create!())
  end

  it "renders the edit trending_daily_news_item form" do
    render

    assert_select "form[action=?][method=?]", trending_daily_news_item_path(@trending_daily_news_item), "post" do
    end
  end
end
