require 'rails_helper'

RSpec.describe "github_news_items/show", type: :view do
  before(:each) do
    @github_news_item = assign(:github_news_item, GithubNewsItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
