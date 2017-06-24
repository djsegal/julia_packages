require "rails_helper"

RSpec.describe VisitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/visits").to route_to("visits#index")
    end

    it "routes to #new" do
      expect(:get => "/visits/new").to route_to("visits#new")
    end

    it "routes to #show" do
      expect(:get => "/visits/1").to route_to("visits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/visits/1/edit").to route_to("visits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/visits").to route_to("visits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/visits/1").to route_to("visits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/visits/1").to route_to("visits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/visits/1").to route_to("visits#destroy", :id => "1")
    end

  end
end
