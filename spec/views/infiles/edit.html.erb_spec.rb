require 'spec_helper'

describe "infiles/edit", :type => :view do
  before(:each) do
    @infile = assign(:infile, stub_model(Infile))
  end

  it "renders the edit infile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", infile_path(@infile), "post" do
    end
  end
end
