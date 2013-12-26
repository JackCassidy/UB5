require 'spec_helper'

describe "peptide_proteins/index" do
  before(:each) do
    assign(:peptide_proteins, [
      stub_model(PeptideProtein,
        :peptide_id => 1,
        :protein_id => 2,
        :protein_mod_site => 3
      ),
      stub_model(PeptideProtein,
        :peptide_id => 1,
        :protein_id => 2,
        :protein_mod_site => 3
      )
    ])
  end

  it "renders a list of peptide_proteins" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
