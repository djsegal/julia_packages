require "rails_helper"

RSpec.describe OwnershipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ownerships").to route_to("ownerships#index")
    end

    it "routes to #new" do
      expect(:get => "/ownerships/new").to route_to("ownerships#new")
    end

    it "routes to #show" do
      expect(:get => "/ownerships/1").to route_to("ownerships#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ownerships/1/edit").to route_to("ownerships#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ownerships").to route_to("ownerships#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ownerships/1").to route_to("ownerships#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ownerships/1").to route_to("ownerships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ownerships/1").to route_to("ownerships#destroy", :id => "1")
    end

  end
end
