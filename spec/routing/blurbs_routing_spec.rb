require "rails_helper"

RSpec.describe BlurbsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/blurbs").to route_to("blurbs#index")
    end

    it "routes to #new" do
      expect(:get => "/blurbs/new").to route_to("blurbs#new")
    end

    it "routes to #show" do
      expect(:get => "/blurbs/1").to route_to("blurbs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blurbs/1/edit").to route_to("blurbs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/blurbs").to route_to("blurbs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/blurbs/1").to route_to("blurbs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/blurbs/1").to route_to("blurbs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blurbs/1").to route_to("blurbs#destroy", :id => "1")
    end

  end
end
