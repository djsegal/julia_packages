require 'rails_helper'

RSpec.describe "github_news_items/index", type: :view do
  before(:each) do
    assign(:github_news_items, [
      GithubNewsItem.create!(),
      GithubNewsItem.create!()
    ])
  end

  it "renders a list of github_news_items" do
    render
  end
end
