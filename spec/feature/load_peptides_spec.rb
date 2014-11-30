require 'spec_helper'

describe 'Load peptides from a file' do
  let(:file_name) { 'tiny_carr.tsv' }

  before do
    @peptide_source_path = UB5::Application.config.peptide_source_path
    UB5::Application.config.peptide_source_path = Rails.root.join('spec', 'fixtures').to_s

    create(:tiny_carr)
  end

  after do
    UB5::Application.config.peptide_source_path = @peptide_source_path
  end

  it 'should load peptides' do
    expect(PeptideSource.count).to eq(1)

    visit pages_data_options_path
    click_on 'Read peptide file'

    select file_name, from: 'peptide_sources'

    click_on 'Upload carr file'

    expect(page).to have_content('10 peptides in database')
  end
end