require 'spec_helper'

describe 'Load proteins from a file' do

  xit 'should load proteins' do
    visit proteins_select_file_path

    input_file_path = Rails.root.join('spec/fixtures/tiny.fasta')
    attach_file('file_path', input_file_path)
    click_on 'Upload file'

    expect(page).to have_content('10 proteins successfully uploaded')
  end
end