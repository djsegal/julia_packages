require "rails_helper"

RSpec.describe DependenciesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/dependencies").to route_to("dependencies#index")
    end

    it "routes to #new" do
      expect(:get => "/dependencies/new").to route_to("dependencies#new")
    end

    it "routes to #show" do
      expect(:get => "/dependencies/1").to route_to("dependencies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/dependencies/1/edit").to route_to("dependencies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/dependencies").to route_to("dependencies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dependencies/1").to route_to("dependencies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dependencies/1").to route_to("dependencies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dependencies/1").to route_to("dependencies#destroy", :id => "1")
    end

  end
end
