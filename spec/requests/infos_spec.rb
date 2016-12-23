require 'rails_helper'

RSpec.describe "Infos", type: :request do
  describe "GET /infos" do
    it "works! (now write some real specs)" do
      get infos_path
      expect(response).to have_http_status(200)
    end
  end
end
