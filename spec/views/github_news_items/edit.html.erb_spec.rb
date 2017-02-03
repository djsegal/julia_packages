require 'rails_helper'

RSpec.describe "github_news_items/edit", type: :view do
  before(:each) do
    @github_news_item = assign(:github_news_item, GithubNewsItem.create!())
  end

  it "renders the edit github_news_item form" do
    render

    assert_select "form[action=?][method=?]", github_news_item_path(@github_news_item), "post" do
    end
  end
end
