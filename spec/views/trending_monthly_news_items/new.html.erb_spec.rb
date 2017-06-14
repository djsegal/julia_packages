require 'rails_helper'

RSpec.describe "trending_monthly_news_items/new", type: :view do
  before(:each) do
    assign(:trending_monthly_news_item, TrendingMonthlyNewsItem.new())
  end

  it "renders new trending_monthly_news_item form" do
    render

    assert_select "form[action=?][method=?]", trending_monthly_news_items_path, "post" do
    end
  end
end
