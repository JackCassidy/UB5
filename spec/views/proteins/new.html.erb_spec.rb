require 'spec_helper'

describe "proteins/new" do
  before(:each) do
    assign(:protein, stub_model(Protein,
      :sp_or_tr => "MyString",
      :accession => "MyString",
      :description => "MyString",
      :aa_sequence => "MyText"
    ).as_new_record)
  end

  it "renders new protein form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proteins_path, :method => "post" do
      assert_select "input#protein_sp_or_tr", :name => "protein[sp_or_tr]"
      assert_select "input#protein_accession", :name => "protein[accession]"
      assert_select "input#protein_description", :name => "protein[description]"
      assert_select "textarea#protein_aa_sequence", :name => "protein[aa_sequence]"
    end
  end
end
