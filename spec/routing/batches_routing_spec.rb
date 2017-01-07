require "rails_helper"

RSpec.describe BatchesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/batches").to route_to("batches#index")
    end

    it "routes to #new" do
      expect(:get => "/batches/new").to route_to("batches#new")
    end

    it "routes to #show" do
      expect(:get => "/batches/1").to route_to("batches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/batches/1/edit").to route_to("batches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/batches").to route_to("batches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/batches/1").to route_to("batches#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/batches/1").to route_to("batches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/batches/1").to route_to("batches#destroy", :id => "1")
    end

  end
end
