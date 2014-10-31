require 'spec_helper'

describe 'Load infiles' do

  it 'should load a carr file successfully' do
    visit infiles_select_path

    input_file_path = Rails.root.join('spec/fixtures/tiny_carr.tsv')
    attach_file('infile', input_file_path)
    click_on 'Upload file'

    expect(page).to have_content('Infile was successfully created.')
  end
end