require 'rails_helper'

RSpec.describe "reddit_news_items/new", type: :view do
  before(:each) do
    assign(:reddit_news_item, RedditNewsItem.new())
  end

  it "renders new reddit_news_item form" do
    render

    assert_select "form[action=?][method=?]", reddit_news_items_path, "post" do
    end
  end
end
