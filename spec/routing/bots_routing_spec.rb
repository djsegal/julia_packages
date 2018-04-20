require "rails_helper"

RSpec.describe BotsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bots").to route_to("bots#index")
    end

    it "routes to #new" do
      expect(:get => "/bots/new").to route_to("bots#new")
    end

    it "routes to #show" do
      expect(:get => "/bots/1").to route_to("bots#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bots/1/edit").to route_to("bots#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bots").to route_to("bots#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bots/1").to route_to("bots#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bots/1").to route_to("bots#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bots/1").to route_to("bots#destroy", :id => "1")
    end

  end
end
