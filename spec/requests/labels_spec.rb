require 'rails_helper'

RSpec.describe "Labels", type: :request do
  describe "GET /labels" do
    it "works! (now write some real specs)" do
      get labels_path
      expect(response).to have_http_status(200)
    end
  end
end
