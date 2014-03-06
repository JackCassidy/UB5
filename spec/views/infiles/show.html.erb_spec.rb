require 'spec_helper'

describe "infiles/show" do
  before(:each) do
    @infile = assign(:infile, stub_model(Infile))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
