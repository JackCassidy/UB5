require "spec_helper"

describe InfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/infiles").should route_to("infiles#index")
    end

    it "routes to #new" do
      get("/infiles/new").should route_to("infiles#new")
    end

    it "routes to #show" do
      get("/infiles/1").should route_to("infiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/infiles/1/edit").should route_to("infiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/infiles").should route_to("infiles#create")
    end

    it "routes to #update" do
      put("/infiles/1").should route_to("infiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/infiles/1").should route_to("infiles#destroy", :id => "1")
    end

  end
end
