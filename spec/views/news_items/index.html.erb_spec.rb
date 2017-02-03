require 'rails_helper'

RSpec.describe "news_items/index", type: :view do
  before(:each) do
    assign(:news_items, [
      NewsItem.create!(
        :name => "Name",
        :target => nil,
        :link => "Link"
      ),
      NewsItem.create!(
        :name => "Name",
        :target => nil,
        :link => "Link"
      )
    ])
  end

  it "renders a list of news_items" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
