require 'spec_helper'

def upload_file
  attach_file('peptide_source', input_file_path)
  fill_in 'parse_method', :with => parse_method
  click_on 'Add file'
end

describe 'Uploading peptide_sources' do

  after(:each) do
    dir_path = UB5::Application.config.peptide_source_path

    Dir.foreach(dir_path) do |file_name|
      fn = File.join(dir_path, file_name)
      File.delete(fn) unless (File.directory?(fn) || file_name == '.gitignore')
    end
  end


  let(:input_file_path) { Rails.root.join('spec/fixtures/tiny_carr.tsv') }
  let(:parse_method) { 'carr' }
  let(:file_name) { 'tiny_carr.tsv' }

  it 'should add save the file to the local file system' do
    uploaded_peptide_source_directory = Dir.new(UB5::Application.config.peptide_source_path)
    visit new_peptide_source_path
    expect(uploaded_peptide_source_directory.entries).to_not include('tiny_carr.tsv')

    upload_file

    expect(uploaded_peptide_source_directory.entries).to include('tiny_carr.tsv')
  end

  it 'should show the file information' do
    Timecop.freeze
    time = Time.now.utc
    regexp = Regexp.new("#{file_name}\s+#{parse_method}\s+true\s+#{time}")

    visit new_peptide_source_path
    expect(page).to_not have_content(regexp)

    upload_file

    expect(page).to have_content(regexp)
  end

  it 'should save an entry in the peptide_sources table' do
    Timecop.freeze
    time = Time.now.utc

    visit new_peptide_source_path
    expect(PeptideSource.count).to eq(0)

    upload_file

    peptide_source = PeptideSource.last
    expect(peptide_source.file_name).to eq(file_name)
  end

  context "when there is a pre-existing peptide source" do
    let!(:existing_peptide_source) { create(:peptide_source) }

    it "should show the existing peptide_sources" do
      visit new_peptide_source_path
      expect(page).to have_content(existing_peptide_source.file_name)
    end
  end
end
