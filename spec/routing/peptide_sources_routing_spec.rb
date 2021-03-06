require "spec_helper"

describe PeptideSourcesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/peptide_sources")).to route_to("peptide_sources#index")
    end

    it "routes to #new" do
      expect(get("/peptide_sources/new")).to route_to("peptide_sources#new")
    end

    it "routes to #show" do
      expect(get("/peptide_sources/1")).to route_to("peptide_sources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/peptide_sources/1/edit")).to route_to("peptide_sources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/peptide_sources")).to route_to("peptide_sources#create")
    end

    it "routes to #update" do
      expect(put("/peptide_sources/1")).to route_to("peptide_sources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/peptide_sources/1")).to route_to("peptide_sources#destroy", :id => "1")
    end

  end
end
