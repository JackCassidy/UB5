require 'spec_helper'

describe "peptide_sources/new", :type => :view do
  before(:each) do
    assign(:peptide_source, stub_model(PeptideSource).as_new_record)
  end

  pending "renders new peptide_source form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", peptide_sources_path, "post" do
    end
  end
end
