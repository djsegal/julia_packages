require 'rails_helper'

RSpec.describe "reddit_news_items/edit", type: :view do
  before(:each) do
    @reddit_news_item = assign(:reddit_news_item, RedditNewsItem.create!())
  end

  it "renders the edit reddit_news_item form" do
    render

    assert_select "form[action=?][method=?]", reddit_news_item_path(@reddit_news_item), "post" do
    end
  end
end
