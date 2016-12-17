require 'rails_helper'

RSpec.describe "Dummies", type: :request do
  describe "GET /dummies" do
    it "works! (now write some real specs)" do
      get dummies_path
      expect(response).to have_http_status(200)
    end
  end
end
