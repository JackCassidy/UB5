require 'spec_helper'
require 'capybara'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Ubiquitin'" do
      visit '/static_pages/home'
      expect(page).to have_content('Ubiquitin')
    end

    it "should be the root" do
      visit 'http://localhost:3000/'
      expect(page).to have_content('Ubiquitin')
    end

    it "should have links to protein and peptide" do
      visit '/static_pages/home'
      page { should have_link('Proteins', href: proteins_path) }
    end

  end
end