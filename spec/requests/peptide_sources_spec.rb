require 'spec_helper'

describe "PeptideSources", :type => :request do
  describe "GET /peptide_sources" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get peptide_sources_path
      expect(response.status).to be(200)
    end
  end
end
