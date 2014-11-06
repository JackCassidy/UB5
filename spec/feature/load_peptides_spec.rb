require 'spec_helper'

describe 'Load peptides from a file' do

  it 'should load peptides' do
    visit static_pages_data_options_path
    click_on 'Read peptide file'

    input_file_path = Rails.root.join('spec/fixtures/peptides_for_parsimony.tsv')
    attach_file('peptide_file', input_file_path)
    click_on 'Upload carr file'

    expect(page).to have_content('10 peptides in database')
  end
end