require 'spec_helper'

describe "peptides/edit", :type => :view do
  before(:each) do
    @peptide = assign(:peptide, stub_model(Peptide,
      :aseq => "MyString"
    ))
  end

  it "renders the edit peptide form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => peptides_path(@peptide), :method => "post" do
      assert_select "input#peptide_aseq", :name => "peptide[aseq]"
    end
  end
end
