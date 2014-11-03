require 'spec_helper'


# Find all matches in the two tables.  If a match is already in the table, do not make a duplicate entry
describe 'Find all proteins for all peptides' do
  let!(:peptide_i) { create(:peptide, :aseq => 'III') }
  let!(:protein_1) { create(:protein, :aa_sequence => 'IIIYMMMMMMMMMYAGGGMMMM') } # one existing and one new match #todo figure out what to do with overlapping or repeated

  before do
    create(:peptide_protein, protein_id: protein_1.id, peptide_id: peptide_i.id, protein_mod_site: 1) #existing match that is in the current data set
  end

  it 'finds the proteins for the peptides' do

    visit static_pages_data_options_path

    click_on 'Find peptides in proteins'

    expect(page).to have_content('Found 1 matches')
  end
end