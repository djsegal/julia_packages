require "rails_helper"

RSpec.describe InfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/infos").to route_to("infos#index")
    end

    it "routes to #new" do
      expect(:get => "/infos/new").to route_to("infos#new")
    end

    it "routes to #show" do
      expect(:get => "/infos/1").to route_to("infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/infos/1/edit").to route_to("infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/infos").to route_to("infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/infos/1").to route_to("infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/infos/1").to route_to("infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/infos/1").to route_to("infos#destroy", :id => "1")
    end

  end
end
