require 'rails_helper'

RSpec.describe "TrendingDailyNewsItems", type: :request do
  describe "GET /trending_daily_news_items" do
    it "works! (now write some real specs)" do
      get trending_daily_news_items_path
      expect(response).to have_http_status(200)
    end
  end
end
