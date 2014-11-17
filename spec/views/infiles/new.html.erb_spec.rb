require 'spec_helper'

describe "infiles/new", :type => :view do
  before(:each) do
    assign(:infile, stub_model(Infile).as_new_record)
  end

  pending "renders new infile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", infiles_path, "post" do
    end
  end
end
