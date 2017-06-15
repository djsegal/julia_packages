require 'rails_helper'

RSpec.describe "stack_overflow_news_items/edit", type: :view do
  before(:each) do
    @stack_overflow_news_item = assign(:stack_overflow_news_item, StackOverflowNewsItem.create!())
  end

  it "renders the edit stack_overflow_news_item form" do
    render

    assert_select "form[action=?][method=?]", stack_overflow_news_item_path(@stack_overflow_news_item), "post" do
    end
  end
end
