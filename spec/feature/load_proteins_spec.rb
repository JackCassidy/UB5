require 'spec_helper'

describe 'Load proteins from a file' do

  xit 'should load proteins' do
    visit proteins_load_path

    input_file_path = Rails.root.join('spec/fixtures/tiny.fasta')
    attach_file('tsv_file', input_file_path)
    click 'Upload file'

    expect(page).to have('10 proteins successfully uploaded')
  end
end