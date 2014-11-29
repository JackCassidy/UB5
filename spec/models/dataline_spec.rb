require 'spec_helper'


describe Dataline, :type => :model do

  describe 'validations' do
    describe 'associations' do
      it { is_expected.to have_many(:peptides) }
      it { is_expected.to belong_to(:peptide_source) }
    end

    describe 'mass-assignable' do
      it { is_expected.to allow_mass_assignment_of(:tsv_string) }
      it { is_expected.to allow_mass_assignment_of(:file_order) }
      it { is_expected.to allow_mass_assignment_of(:peptide_source_id) }
    end

    it { is_expected.to validate_presence_of :tsv_string }

    it { is_expected.to have_many :peptides }

    it { is_expected.to belong_to :peptide_source }
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

  describe "#parse_peptides" do
    let(:parse_method) { 'some parse method' }
    let!(:dataline) { create(:dataline) }

    before do
      allow(Dataline).to receive(:look_up_peptide_column).with(parse_method).and_return(1)
    end

    context "when there are enough entries in the dataline" do
      let(:peptide_column) { 1 }

      it "calls one_row_peptide with the right parameters" do
        expect(Peptide).to receive(:one_raw_peptide).with(parse_method, 'DDD', dataline)

        dataline.parse_peptides(parse_method, peptide_column)
      end
    end
    context "when there are not enough entries in the dataline" do
      let(:peptide_column) { 2 }

      it "returns without calling one_raw_peptide" do
        expect(Peptide).to_not receive(:one_raw_peptide)

        dataline.parse_peptides(parse_method, peptide_column)
      end
    end
  end
end
