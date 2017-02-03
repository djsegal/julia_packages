require 'rails_helper'

RSpec.describe "Blurbs", type: :request do
  describe "GET /blurbs" do
    it "works! (now write some real specs)" do
      get blurbs_path
      expect(response).to have_http_status(200)
    end
  end
end
