require 'spec_helper'

describe "proteins/show", :type => :view do
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
    expect(rendered).to match(/Sp Or Tr/)
    expect(rendered).to match(/Accession/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/MyText/)
  end
end
