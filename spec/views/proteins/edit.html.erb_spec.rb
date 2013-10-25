require 'spec_helper'

describe "proteins/edit" do
  before(:each) do
    @protein = assign(:protein, stub_model(Protein,
      :sp_or_tr => "MyString",
      :accession => "MyString",
      :description => "MyString",
      :aa_sequence => "MyText"
    ))
  end

  it "renders the edit protein form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proteins_path(@protein), :method => "post" do
      assert_select "input#protein_sp_or_tr", :name => "protein[sp_or_tr]"
      assert_select "input#protein_accession", :name => "protein[accession]"
      assert_select "input#protein_description", :name => "protein[description]"
      assert_select "textarea#protein_aa_sequence", :name => "protein[aa_sequence]"
    end
  end
end
