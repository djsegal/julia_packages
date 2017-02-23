require "rails_helper"

RSpec.describe ReleasesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/releases").to route_to("releases#index")
    end

    it "routes to #new" do
      expect(:get => "/releases/new").to route_to("releases#new")
    end

    it "routes to #show" do
      expect(:get => "/releases/1").to route_to("releases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/releases/1/edit").to route_to("releases#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/releases").to route_to("releases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/releases/1").to route_to("releases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/releases/1").to route_to("releases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/releases/1").to route_to("releases#destroy", :id => "1")
    end

  end
end
