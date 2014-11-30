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


  describe "#parse_peptides" do
    let(:parse_method) { 'some parse method' }
    let!(:dataline) { create(:dataline) }

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
