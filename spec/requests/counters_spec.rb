require 'rails_helper'

RSpec.describe "Counters", type: :request do
  describe "GET /counters" do
    it "works! (now write some real specs)" do
      get counters_path
      expect(response).to have_http_status(200)
    end
  end
end
