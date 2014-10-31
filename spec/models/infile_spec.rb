require 'spec_helper'
include ActionDispatch::TestProcess
describe Infile do
  describe 'validations' do
    it { is_expected.to allow_mass_assignment_of(:file_name) }
    it { is_expected.to allow_mass_assignment_of(:file_size) }
    it { is_expected.to allow_mass_assignment_of(:first_line) }
    it { is_expected.to allow_mass_assignment_of(:parse_method) }
    it { is_expected.to allow_mass_assignment_of(:peptide_column) }

    it { is_expected.to have_many(:datalines) }

    it { is_expected.to validate_presence_of(:file_name) }
    it { is_expected.to validate_presence_of(:file_size) }
    it { is_expected.to validate_presence_of(:first_line) }
    it { is_expected.to validate_presence_of(:parse_method) }
    it { is_expected.to validate_presence_of(:peptide_column) }
  end

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

  describe 'other methods' do
    pending
  end
end