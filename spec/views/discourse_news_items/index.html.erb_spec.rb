require 'rails_helper'

RSpec.describe "discourse_news_items/index", type: :view do
  before(:each) do
    assign(:discourse_news_items, [
      DiscourseNewsItem.create!(),
      DiscourseNewsItem.create!()
    ])
  end

  it "renders a list of discourse_news_items" do
    render
  end
end
