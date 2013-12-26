require "spec_helper"

describe PeptideProteinsController do
  describe "routing" do

    it "routes to #index" do
      get("/peptide_proteins").should route_to("peptide_proteins#index")
    end

    it "routes to #new" do
      get("/peptide_proteins/new").should route_to("peptide_proteins#new")
    end

    it "routes to #show" do
      get("/peptide_proteins/1").should route_to("peptide_proteins#show", :id => "1")
    end

    it "routes to #edit" do
      get("/peptide_proteins/1/edit").should route_to("peptide_proteins#edit", :id => "1")
    end

    it "routes to #create" do
      post("/peptide_proteins").should route_to("peptide_proteins#create")
    end

    it "routes to #update" do
      put("/peptide_proteins/1").should route_to("peptide_proteins#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/peptide_proteins/1").should route_to("peptide_proteins#destroy", :id => "1")
    end

  end
end
