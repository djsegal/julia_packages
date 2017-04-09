require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /searches" do
    it "works! (now write some real specs)" do
      get searches_path
      expect(response).to have_http_status(200)
    end
  end
end
