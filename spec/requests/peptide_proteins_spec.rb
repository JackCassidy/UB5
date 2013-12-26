require 'spec_helper'

describe "PeptideProteins" do
  describe "GET /peptide_proteins" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get peptide_proteins_path
      response.status.should be(200)
    end
  end
end
