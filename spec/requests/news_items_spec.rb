require 'rails_helper'

RSpec.describe "NewsItems", type: :request do
  describe "GET /news_items" do
    it "works! (now write some real specs)" do
      get news_items_path
      expect(response).to have_http_status(200)
    end
  end
end
