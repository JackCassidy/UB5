require 'spec_helper'

describe 'Load peptides from a file' do

  it 'should load proteins' do
    visit peptides_select_peptide_file_path

    input_file_path = Rails.root.join('spec/fixtures/peptides_for_parsimony.tsv')
    attach_file('carr_file', input_file_path)
    click_on 'Upload carr file'

    expect(page).to have_content('9 peptides in database')

  end
end