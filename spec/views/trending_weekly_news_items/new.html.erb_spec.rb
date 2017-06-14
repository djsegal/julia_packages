require 'rails_helper'

RSpec.describe "trending_weekly_news_items/new", type: :view do
  before(:each) do
    assign(:trending_weekly_news_item, TrendingWeeklyNewsItem.new())
  end

  it "renders new trending_weekly_news_item form" do
    render

    assert_select "form[action=?][method=?]", trending_weekly_news_items_path, "post" do
    end
  end
end
