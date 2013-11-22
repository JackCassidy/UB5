require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

    it "should have the content 'UB Consolidation'"  do
      visit '/static_pages/home'
      expect(page).to have_content('UB Consolidation')
    end

  end  # Home page

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

  end  # Help page

end
