require 'rails_helper'

RSpec.describe "discourse_news_items/new", type: :view do
  before(:each) do
    assign(:discourse_news_item, DiscourseNewsItem.new())
  end

  it "renders new discourse_news_item form" do
    render

    assert_select "form[action=?][method=?]", discourse_news_items_path, "post" do
    end
  end
end
