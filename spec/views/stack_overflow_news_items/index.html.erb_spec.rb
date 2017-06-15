require 'rails_helper'

RSpec.describe "stack_overflow_news_items/index", type: :view do
  before(:each) do
    assign(:stack_overflow_news_items, [
      StackOverflowNewsItem.create!(),
      StackOverflowNewsItem.create!()
    ])
  end

  it "renders a list of stack_overflow_news_items" do
    render
  end
end
