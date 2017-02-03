require 'rails_helper'

RSpec.describe "discourse_news_items/show", type: :view do
  before(:each) do
    @discourse_news_item = assign(:discourse_news_item, DiscourseNewsItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
