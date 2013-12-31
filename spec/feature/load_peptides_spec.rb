require 'spec_helper'

describe 'Load peptides from a file' do

  xit 'should load proteins' do
    visit peptides_select_file_path

    input_file_path = Rails.root.join('spec/fixtures/peptides_for_parsimony.tsv')
    attach_file('fasta_file', input_file_path)
    click_on 'Upload file'

    expect(page).to have_content('peptides now in database')

  end
end