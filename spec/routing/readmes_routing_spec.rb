require "rails_helper"

RSpec.describe ReadmesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/readmes").to route_to("readmes#index")
    end

    it "routes to #new" do
      expect(:get => "/readmes/new").to route_to("readmes#new")
    end

    it "routes to #show" do
      expect(:get => "/readmes/1").to route_to("readmes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/readmes/1/edit").to route_to("readmes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/readmes").to route_to("readmes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/readmes/1").to route_to("readmes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/readmes/1").to route_to("readmes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/readmes/1").to route_to("readmes#destroy", :id => "1")
    end

  end
end
