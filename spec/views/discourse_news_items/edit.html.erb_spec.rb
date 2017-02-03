require 'rails_helper'

RSpec.describe "discourse_news_items/edit", type: :view do
  before(:each) do
    @discourse_news_item = assign(:discourse_news_item, DiscourseNewsItem.create!())
  end

  it "renders the edit discourse_news_item form" do
    render

    assert_select "form[action=?][method=?]", discourse_news_item_path(@discourse_news_item), "post" do
    end
  end
end
