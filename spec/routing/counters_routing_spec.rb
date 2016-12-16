require "rails_helper"

RSpec.describe CountersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/counters").to route_to("counters#index")
    end

    it "routes to #new" do
      expect(:get => "/counters/new").to route_to("counters#new")
    end

    it "routes to #show" do
      expect(:get => "/counters/1").to route_to("counters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/counters/1/edit").to route_to("counters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/counters").to route_to("counters#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/counters/1").to route_to("counters#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/counters/1").to route_to("counters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/counters/1").to route_to("counters#destroy", :id => "1")
    end

  end
end
