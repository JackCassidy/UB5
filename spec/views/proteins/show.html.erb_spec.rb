require 'spec_helper'

describe "proteins/show" do
  before(:each) do
    @protein = assign(:protein, stub_model(Protein,
      :sp_or_tr => "Sp Or Tr",
      :accession => "Accession",
      :description => "Description",
      :aa_sequence => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sp Or Tr/)
    rendered.should match(/Accession/)
    rendered.should match(/Description/)
    rendered.should match(/MyText/)
  end
end
