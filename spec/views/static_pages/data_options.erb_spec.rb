require 'spec_helper'
require 'capybara/rails'


describe "buttons on page", :type => :view do
  it "should have 'path to infile text'" do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Select infile'
    click_button('Select infile')
  end

  it "should have a 'Read protein file' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Read protein file'
    click_button('Read protein file')
  end

  it "should have a 'Delete proteins' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Delete proteins'
    click_button('Delete proteins')
  end

  it "should have a 'Read peptide file' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Read peptide file'
    click_button('Read peptide file')
  end

  it "should have a 'Delete peptides' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Delete peptides'
    click_button('Delete peptides')
  end

  it "should have a 'Find peptides in proteins' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Find peptides in proteins'
    click_button('Find peptides in proteins')
  end

  it "should have a 'Apply parsimony' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Apply parsimony'
    click_button('Apply parsimony')
  end

end