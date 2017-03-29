require 'rails_helper'

RSpec.describe "Models", type: :request do
  describe "GET /models" do
    it "works! (now write some real specs)" do
      get models_path
      expect(response).to have_http_status(200)
    end
  end
end
