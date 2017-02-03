require 'rails_helper'

RSpec.describe "reddit_news_items/index", type: :view do
  before(:each) do
    assign(:reddit_news_items, [
      RedditNewsItem.create!(),
      RedditNewsItem.create!()
    ])
  end

  it "renders a list of reddit_news_items" do
    render
  end
end
