require 'spec_helper'
include ActionDispatch::TestProcess

describe '#post_initialize', :type => :model do
  let!(:up_file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/tiny_carr.tsv', 'text/xml'),
                                                       :filename => 'tiny_carr.tsv') }
  before do
    @infile = Infile.new()
    @infile.post_initialize(up_file)
  end

  it "should set the file format (carr ...)" do
    expect(@infile.parse_method).to eq(:carr)
  end

  it "should set the column number" do
    expect(@infile.peptide_column).to eq(3)
  end

end
