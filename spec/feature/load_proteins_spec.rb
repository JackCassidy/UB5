require 'spec_helper'

describe 'Load proteins from a file' do

  it 'should load proteins' do
    visit static_pages_data_options_path
    click_on 'Read protein file'

    input_file_path = Rails.root.join('spec/fixtures/tiny.fasta')
    attach_file('fasta_file', input_file_path)
    click_on 'Upload file'

    expect(page).to have_content('10 proteins now in database')
  end
end