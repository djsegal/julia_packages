require 'rails_helper'

RSpec.describe "GithubNewsItems", type: :request do
  describe "GET /github_news_items" do
    it "works! (now write some real specs)" do
      get github_news_items_path
      expect(response).to have_http_status(200)
    end
  end
end
