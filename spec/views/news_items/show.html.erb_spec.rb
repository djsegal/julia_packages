require 'rails_helper'

RSpec.describe "news_items/show", type: :view do
  before(:each) do
    @news_item = assign(:news_item, NewsItem.create!(
      :name => "Name",
      :target => nil,
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Link/)
  end
end
