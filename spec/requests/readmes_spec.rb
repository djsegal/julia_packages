require 'rails_helper'

RSpec.describe "Readmes", type: :request do
  describe "GET /readmes" do
    it "works! (now write some real specs)" do
      get readmes_path
      expect(response).to have_http_status(200)
    end
  end
end
