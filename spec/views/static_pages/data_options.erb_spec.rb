require 'spec_helper'
require 'capybara/rails'


describe "buttons on page" do

  specify {expect(3).to eq(3) }

  it "should have a 'Read protein file' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Read protein file'
  end

  it "should have a 'Delete proteins' button " do
    visit '/static_pages/data_options'
    expect(page).to have_button 'Delete proteins'
  end

end