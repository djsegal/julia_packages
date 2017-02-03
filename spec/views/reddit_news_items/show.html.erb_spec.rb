require 'rails_helper'

RSpec.describe "reddit_news_items/show", type: :view do
  before(:each) do
    @reddit_news_item = assign(:reddit_news_item, RedditNewsItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
