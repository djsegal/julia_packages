require 'rails_helper'

RSpec.describe "Repositories", type: :request do
  describe "GET /repositories" do
    it "works! (now write some real specs)" do
      get repositories_path
      expect(response).to have_http_status(200)
    end
  end
end
