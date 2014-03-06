require 'spec_helper'

describe "infiles/index" do
  before(:each) do
    assign(:infiles, [
      stub_model(Infile),
      stub_model(Infile)
    ])
  end

  it "renders a list of infiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
