require "spec_helper"

describe PeptidesController do
  describe "routing" do

    it "routes to #index" do
      get("/peptides").should route_to("peptides#index")
    end

    it "routes to #new" do
      get("/peptides/new").should route_to("peptides#new")
    end

    it "routes to #show" do
      get("/peptides/1").should route_to("peptides#show", :id => "1")
    end

    it "routes to #edit" do
      get("/peptides/1/edit").should route_to("peptides#edit", :id => "1")
    end

    it "routes to #create" do
      post("/peptides").should route_to("peptides#create")
    end

    it "routes to #update" do
      put("/peptides/1").should route_to("peptides#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/peptides/1").should route_to("peptides#destroy", :id => "1")
    end

  end
end
