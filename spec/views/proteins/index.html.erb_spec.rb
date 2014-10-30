require 'spec_helper'

describe "proteins/index", :type => :view do
  before(:each) do
    assign(:proteins, [
      stub_model(Protein,
        :sp_or_tr => "Sp Or Tr",
        :accession => "Accession",
        :description => "Description",
        :aa_sequence => "MyText"
      ),
      stub_model(Protein,
        :sp_or_tr => "Sp Or Tr",
        :accession => "Accession",
        :description => "Description",
        :aa_sequence => "MyText"
      )
    ])
  end

  it "renders a list of proteins" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sp Or Tr".to_s, :count => 2
    assert_select "tr>td", :text => "Accession".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
