require 'rails_helper'

RSpec.describe "trending_weekly_news_items/edit", type: :view do
  before(:each) do
    @trending_weekly_news_item = assign(:trending_weekly_news_item, TrendingWeeklyNewsItem.create!())
  end

  it "renders the edit trending_weekly_news_item form" do
    render

    assert_select "form[action=?][method=?]", trending_weekly_news_item_path(@trending_weekly_news_item), "post" do
    end
  end
end
