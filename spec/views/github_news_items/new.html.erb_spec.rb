require 'rails_helper'

RSpec.describe "github_news_items/new", type: :view do
  before(:each) do
    assign(:github_news_item, GithubNewsItem.new())
  end

  it "renders new github_news_item form" do
    render

    assert_select "form[action=?][method=?]", github_news_items_path, "post" do
    end
  end
end
