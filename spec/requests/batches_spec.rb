require 'rails_helper'

RSpec.describe "Batches", type: :request do
  describe "GET /batches" do
    it "works! (now write some real specs)" do
      get batches_path
      expect(response).to have_http_status(200)
    end
  end
end
