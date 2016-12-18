require 'rails_helper'

RSpec.describe "Ownerships", type: :request do
  describe "GET /ownerships" do
    it "works! (now write some real specs)" do
      get ownerships_path
      expect(response).to have_http_status(200)
    end
  end
end
