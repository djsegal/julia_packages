require "rails_helper"

RSpec.describe VersionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/versions").to route_to("versions#index")
    end

    it "routes to #new" do
      expect(:get => "/versions/new").to route_to("versions#new")
    end

    it "routes to #show" do
      expect(:get => "/versions/1").to route_to("versions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/versions/1/edit").to route_to("versions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/versions").to route_to("versions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/versions/1").to route_to("versions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/versions/1").to route_to("versions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/versions/1").to route_to("versions#destroy", :id => "1")
    end

  end
end
