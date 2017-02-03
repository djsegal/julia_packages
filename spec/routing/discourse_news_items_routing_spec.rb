require "rails_helper"

RSpec.describe DiscourseNewsItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/discourse_news_items").to route_to("discourse_news_items#index")
    end

    it "routes to #new" do
      expect(:get => "/discourse_news_items/new").to route_to("discourse_news_items#new")
    end

    it "routes to #show" do
      expect(:get => "/discourse_news_items/1").to route_to("discourse_news_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/discourse_news_items/1/edit").to route_to("discourse_news_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/discourse_news_items").to route_to("discourse_news_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/discourse_news_items/1").to route_to("discourse_news_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/discourse_news_items/1").to route_to("discourse_news_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/discourse_news_items/1").to route_to("discourse_news_items#destroy", :id => "1")
    end

  end
end
