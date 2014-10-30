require "spec_helper"

describe PeptidesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/peptides")).to route_to("peptides#index")
    end

    it "routes to #new" do
      expect(get("/peptides/new")).to route_to("peptides#new")
    end

    it "routes to #show" do
      expect(get("/peptides/1")).to route_to("peptides#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/peptides/1/edit")).to route_to("peptides#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/peptides")).to route_to("peptides#create")
    end

    it "routes to #update" do
      expect(put("/peptides/1")).to route_to("peptides#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/peptides/1")).to route_to("peptides#destroy", :id => "1")
    end

  end
end
