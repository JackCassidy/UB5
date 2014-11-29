require 'spec_helper'

describe "peptide_sources/show", :type => :view do
  before(:each) do
    @peptide_source = assign(:peptide_source, stub_model(PeptideSource))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
