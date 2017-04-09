require 'rails_helper'

RSpec.describe "Dependencies", type: :request do
  describe "GET /dependencies" do
    it "works! (now write some real specs)" do
      get dependencies_path
      expect(response).to have_http_status(200)
    end
  end
end
