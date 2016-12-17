require "rails_helper"

RSpec.describe DummiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/dummies").to route_to("dummies#index")
    end

    it "routes to #new" do
      expect(:get => "/dummies/new").to route_to("dummies#new")
    end

    it "routes to #show" do
      expect(:get => "/dummies/1").to route_to("dummies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/dummies/1/edit").to route_to("dummies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/dummies").to route_to("dummies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dummies/1").to route_to("dummies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dummies/1").to route_to("dummies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dummies/1").to route_to("dummies#destroy", :id => "1")
    end

  end
end
