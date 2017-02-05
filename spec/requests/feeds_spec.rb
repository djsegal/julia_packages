require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  describe "GET /feeds" do
    it "works! (now write some real specs)" do
      get feeds_path
      expect(response).to have_http_status(200)
    end
  end
end
