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

  describe 'file_info' do
    let(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/fake_peptide.txt', 'text/xml'),
                                                        :filename => 'fake_peptide.txt') }
    it "parses file name, file size and first line from the file object" do
      file_info = Infile.file_info(file)
      expect(file_info[:file_name]).to eq('fake_peptide.txt')
      expect(file_info[:file_size]).to eq(25)
      expect(file_info[:first_line]).to eq('Header1 H2 H3')
    end
  end

  describe 'peptide_column' do
    cases = { 'carr' => 3, 'choudary' => 13, 'bennett' => 5 }
    cases.keys.each do |type|
      it "returns the right peptide column for a #{type}" do
        expect(Infile.peptide_column(type)).to eq(cases[type])
      end
    end
  end

  describe '#post_initialize', :type => :model do

    context "when the file passed in is nil" do
      it "does not cause an error" do
        expect{described_class.new.post_initialize}.to_not raise_error
      end
    end

    [
        { :name => 'carr', :peptide_column => 3 },
        { :name => 'choudhary', :peptide_column => 13 },
        { :name => 'bennett', :peptide_column => 5 }
    ].each do |file_type|
      context "when the file is of type #{file_type[:name]}" do
        let!(:up_file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload("/tiny_#{file_type[:name]}.tsv", 'text/xml'),
                                                                :filename => "tiny_#{file_type[:name]}.tsv") }

        it "sets the file format and column number" do
          infile = described_class.new
          infile.post_initialize(up_file)

          expect(infile.parse_method).to eq(file_type[:name].to_sym)
          expect(infile.peptide_column).to eq(file_type[:peptide_column])
        end
      end
    end
  end



  describe 'other methods' do
    pending
  end
end