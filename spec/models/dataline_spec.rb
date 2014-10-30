require 'spec_helper'


describe Dataline, :type => :model do

  describe 'associations' do
    it { is_expected.to have_many(:peptides) }
    it { is_expected.to belong_to(:infile) }
  end

  describe 'mass-assignable' do
    it { is_expected.to allow_mass_assignment_of(:tsv_string) }
    it { is_expected.to allow_mass_assignment_of(:file_order) }
    it { is_expected.to allow_mass_assignment_of(:infile_id) }
  end

  describe '.look_up_peptide_column' do

    parse_method = { 'carr' => 3, 'bennett' => 5, 'choudhary' => 13 }
    parse_method.keys.each do |method|
      it "returns a peptide line position of #{parse_method[method]} for #{method}" do
        expect(described_class.look_up_peptide_column(method)).to eq(parse_method[method])
      end
    end

    it "aborts with the right message when there is an unrecognized parse method" do
      expect(lambda { described_class.look_up_peptide_column('foo') }).to raise_error(
                                                                              error = SystemExit,
                                                                              message = "** Unrecognized parse method foo **")
    end
  end

  describe 'other methodes' do
    pending 'add spec after changing test seed file into factories'
  end
end
