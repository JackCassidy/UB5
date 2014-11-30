require 'spec_helper'
require 'capybara/rails'


describe "buttons on page", :type => :view do
  it "should have 'path to peptide_source text'" do
    visit pages_data_options_path
    expect(page).to have_button 'Select peptide_source'
    click_button('Select peptide_source')
  end

  it "should have a 'Read protein file' button " do
    visit pages_data_options_path
    expect(page).to have_button 'Read protein file'
    click_button('Read protein file')
  end

  it "should have a 'Delete proteins' button " do
    visit pages_data_options_path
    expect(page).to have_button 'Delete proteins'
    click_button('Delete proteins')
  end

  it "should have a 'Read peptide file' button " do
    visit pages_data_options_path
    expect(page).to have_button 'Parse peptides from source'
    click_button('Parse peptides from source')
  end

  it "should have a 'Delete peptides' button " do
    visit pages_data_options_path
    expect(page).to have_button 'Delete peptides'
    click_button('Delete peptides')
  end

  it "should have a 'Find peptides in proteins' button " do
    visit pages_data_options_path
    expect(page).to have_button 'Find peptides in proteins'
    click_button('Find peptides in proteins')
  end

  it "should have a 'Apply parsimony' button " do
    visit pages_data_options_path
    expect(page).to have_button 'Apply parsimony'
    click_button('Apply parsimony')
  end
end

describe "links at bottom of page" do
    it "should have links to protein and peptide" do
      visit pages_data_options_path
      page { is_expected.to have_link('Proteins', href: proteins_path) }
    end
    it "should have links to protein and peptide" do
      visit pages_data_options_path
      page { is_expected.to have_link('Proteins', href: proteins_path) }
    end
end