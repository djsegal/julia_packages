require 'rails_helper'

RSpec.describe "stack_overflow_news_items/show", type: :view do
  before(:each) do
    @stack_overflow_news_item = assign(:stack_overflow_news_item, StackOverflowNewsItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
