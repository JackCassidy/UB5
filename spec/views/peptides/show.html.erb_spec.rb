require 'spec_helper'

describe "peptides/show" do
  before(:each) do
    @peptide = assign(:peptide, stub_model(Peptide,
      :aseq => "Aseq"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Aseq/)
  end
end
