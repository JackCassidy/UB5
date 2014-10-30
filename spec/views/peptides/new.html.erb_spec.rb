require 'spec_helper'

describe "peptides/new", :type => :view do
  before(:each) do
    assign(:peptide, stub_model(Peptide,
      :aseq => "MyString"
    ).as_new_record)
  end

  it "renders new peptide form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => peptides_path, :method => "post" do
      assert_select "input#peptide_aseq", :name => "peptide[aseq]"
    end
  end
end
