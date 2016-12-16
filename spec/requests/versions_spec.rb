require 'rails_helper'

RSpec.describe "Versions", type: :request do
  describe "GET /versions" do
    it "works! (now write some real specs)" do
      get versions_path
      expect(response).to have_http_status(200)
    end
  end
end
