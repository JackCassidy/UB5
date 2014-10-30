require 'spec_helper'

describe "peptide_proteins/show", :type => :view do
  before(:each) do
    @peptide_protein = assign(:peptide_protein, stub_model(PeptideProtein,
      :peptide_id => 1,
      :protein_id => 2,
      :protein_mod_site => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
