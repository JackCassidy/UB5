require 'spec_helper'

describe "peptide_proteins/new", :type => :view do
  before(:each) do
    assign(:peptide_protein, stub_model(PeptideProtein,
      :peptide_id => 1,
      :protein_id => 1,
      :protein_mod_site => 1
    ).as_new_record)
  end

  it "renders new peptide_protein form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", peptide_proteins_path, "post" do
      assert_select "input#peptide_protein_peptide_id[name=?]", "peptide_protein[peptide_id]"
      assert_select "input#peptide_protein_protein_id[name=?]", "peptide_protein[protein_id]"
      assert_select "input#peptide_protein_protein_mod_site[name=?]", "peptide_protein[protein_mod_site]"
    end
  end
end
