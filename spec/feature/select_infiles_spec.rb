require 'spec_helper'

describe 'Load infiles' do

  let!(:existing_infile) { create(:infile) }


  it 'should have a select file button' do
    visit static_pages_data_options_path
    click_on 'Select infile'

    expect(page).to have_content('infile') # This is the name of the Choose File button
  end

  it 'should add a line to Infiles for the selected file' do
    visit static_pages_data_options_path
    click_on 'Select infile'

    expect(page).to have_content(existing_infile.file_name)

    input_file_path = Rails.root.join('spec/fixtures/tiny_carr.tsv')
    attach_file('infile', input_file_path)

    fill_in 'parse_method', :with => 'carr'

    expect(page).to_not have_content('tiny_carr')
    click_on 'Add file'

    expect(page).to have_content('tiny_carr')
  end

end