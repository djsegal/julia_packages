require 'rails_helper'

RSpec.describe "trending_monthly_news_items/edit", type: :view do
  before(:each) do
    @trending_monthly_news_item = assign(:trending_monthly_news_item, TrendingMonthlyNewsItem.create!())
  end

  it "renders the edit trending_monthly_news_item form" do
    render

    assert_select "form[action=?][method=?]", trending_monthly_news_item_path(@trending_monthly_news_item), "post" do
    end
  end
end
