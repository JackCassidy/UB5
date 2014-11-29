require 'spec_helper'

describe "peptide_sources/index", :type => :view do
  before(:each) do
    assign(:peptide_sources, [
      stub_model(PeptideSource),
      stub_model(PeptideSource)
    ])
  end

  it "renders a list of peptide_sources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
