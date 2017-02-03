require "rails_helper"

RSpec.describe ReferencesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/references").to route_to("references#index")
    end

    it "routes to #new" do
      expect(:get => "/references/new").to route_to("references#new")
    end

    it "routes to #show" do
      expect(:get => "/references/1").to route_to("references#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/references/1/edit").to route_to("references#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/references").to route_to("references#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/references/1").to route_to("references#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/references/1").to route_to("references#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/references/1").to route_to("references#destroy", :id => "1")
    end

  end
end
