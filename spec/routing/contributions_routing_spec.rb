require "rails_helper"

RSpec.describe ContributionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/contributions").to route_to("contributions#index")
    end

    it "routes to #new" do
      expect(:get => "/contributions/new").to route_to("contributions#new")
    end

    it "routes to #show" do
      expect(:get => "/contributions/1").to route_to("contributions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/contributions/1/edit").to route_to("contributions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/contributions").to route_to("contributions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/contributions/1").to route_to("contributions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/contributions/1").to route_to("contributions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contributions/1").to route_to("contributions#destroy", :id => "1")
    end

  end
end
