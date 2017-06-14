require "rails_helper"

RSpec.describe TrendingsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/trendings/new").to route_to("trendings#new")
    end

    it "routes to #show" do
      expect(:get => "/trendings/1").to route_to("trendings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trendings/1/edit").to route_to("trendings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trendings").to route_to("trendings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trendings/1").to route_to("trendings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trendings/1").to route_to("trendings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trendings/1").to route_to("trendings#destroy", :id => "1")
    end

  end
end
