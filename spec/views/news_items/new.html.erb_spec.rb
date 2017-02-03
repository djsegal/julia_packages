require 'rails_helper'

RSpec.describe "news_items/new", type: :view do
  before(:each) do
    assign(:news_item, NewsItem.new(
      :name => "MyString",
      :target => nil,
      :link => "MyString"
    ))
  end

  it "renders new news_item form" do
    render

    assert_select "form[action=?][method=?]", news_items_path, "post" do

      assert_select "input#news_item_name[name=?]", "news_item[name]"

      assert_select "input#news_item_target_id[name=?]", "news_item[target_id]"

      assert_select "input#news_item_link[name=?]", "news_item[link]"
    end
  end
end
