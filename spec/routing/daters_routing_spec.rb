require "rails_helper"

RSpec.describe DatersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/daters").to route_to("daters#index")
    end

    it "routes to #new" do
      expect(:get => "/daters/new").to route_to("daters#new")
    end

    it "routes to #show" do
      expect(:get => "/daters/1").to route_to("daters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/daters/1/edit").to route_to("daters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/daters").to route_to("daters#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/daters/1").to route_to("daters#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/daters/1").to route_to("daters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/daters/1").to route_to("daters#destroy", :id => "1")
    end

  end
end
