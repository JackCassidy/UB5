require 'spec_helper'
include ActionDispatch::TestProcess

describe PeptideSource do
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

  describe 'parameters_from_temp_file' do
    let(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/fake_peptide.txt', 'text/xml'),
                                                        :filename => 'fake_peptide.txt') }
    it 'returns parameters for peptide_source calculated from the temp file' do
      expect(PeptideSource.parameters_from_temp_file(file)).to eq({:file_name => 'fake_peptide.txt',
                                                           :file_size => 25,
                                                           :first_line => 'Header1 H2 H3'})
    end
  end

  describe 'peptide_column' do
    cases = { 'carr' => 3, 'choudhary' => 13, 'bennett' => 5 }
    cases.keys.each do |type|
      it "returns the right peptide column for a #{type}" do
        expect(PeptideSource.peptide_column(type)).to eq(cases[type])
      end
    end
  end

  describe '#post_initialize', :type => :model do

    context "when the file passed in is nil" do
      it "does not cause an error" do
        expect { described_class.new.post_initialize }.to_not raise_error
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
          peptide_source = described_class.new
          peptide_source.post_initialize(up_file)

          expect(peptide_source.parse_method).to eq(file_type[:name].to_sym)
          expect(peptide_source.peptide_column).to eq(file_type[:peptide_column])
        end
      end
    end
  end


  describe 'other methods' do
    pending
  end
end