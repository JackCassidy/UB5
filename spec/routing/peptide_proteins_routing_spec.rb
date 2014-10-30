require "spec_helper"

describe PeptideProteinsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/peptide_proteins")).to route_to("peptide_proteins#index")
    end

    it "routes to #new" do
      expect(get("/peptide_proteins/new")).to route_to("peptide_proteins#new")
    end

    it "routes to #show" do
      expect(get("/peptide_proteins/1")).to route_to("peptide_proteins#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/peptide_proteins/1/edit")).to route_to("peptide_proteins#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/peptide_proteins")).to route_to("peptide_proteins#create")
    end

    it "routes to #update" do
      expect(put("/peptide_proteins/1")).to route_to("peptide_proteins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/peptide_proteins/1")).to route_to("peptide_proteins#destroy", :id => "1")
    end

  end
end
