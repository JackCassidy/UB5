require 'spec_helper'

describe "peptides/index" do
  before(:each) do
    assign(:peptides, [
      stub_model(Peptide,
        :aseq => "Aseq"
      ),
      stub_model(Peptide,
        :aseq => "Aseq"
      )
    ])
  end

  it "renders a list of peptides" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Aseq".to_s, :count => 2
  end
end
