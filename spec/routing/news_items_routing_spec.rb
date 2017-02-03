require "rails_helper"

RSpec.describe NewsItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/news_items").to route_to("news_items#index")
    end

    it "routes to #new" do
      expect(:get => "/news_items/new").to route_to("news_items#new")
    end

    it "routes to #show" do
      expect(:get => "/news_items/1").to route_to("news_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/news_items/1/edit").to route_to("news_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/news_items").to route_to("news_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/news_items/1").to route_to("news_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/news_items/1").to route_to("news_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/news_items/1").to route_to("news_items#destroy", :id => "1")
    end

  end
end
