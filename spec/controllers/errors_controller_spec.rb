require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #pardon" do
    it "returns http success" do
      get :pardon
      expect(response).to have_http_status(:success)
    end
  end

end
