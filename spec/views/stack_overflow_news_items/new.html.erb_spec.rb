require 'rails_helper'

RSpec.describe "stack_overflow_news_items/new", type: :view do
  before(:each) do
    assign(:stack_overflow_news_item, StackOverflowNewsItem.new())
  end

  it "renders new stack_overflow_news_item form" do
    render

    assert_select "form[action=?][method=?]", stack_overflow_news_items_path, "post" do
    end
  end
end
