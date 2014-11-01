require 'spec_helper'

describe 'delete peptides' do
  before do
    create(:peptide)
    create(:peptide, :aseq => 'SNSSNTNTSNTS', :mod_loc => 13, :nth => 5, :dataline_id => 1)
  end

  it 'deletes all the peptides and confirms that it was done' do
    expect(Peptide.count).to eq(2)

    visit peptides_confirm_delete_all_path
    click_on 'Delete all peptides'

    expect(page).to have_content('All 2 peptides have been deleted from the database')
    expect(Peptide.count).to eq(0)
  end
end