require 'rails_helper'

RSpec.describe "Activities", type: :request do
  describe "GET /activities" do
    it "works! (now write some real specs)" do
      get activities_path
      expect(response).to have_http_status(200)
    end
  end
end
