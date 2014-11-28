require 'spec_helper'
require 'capybara'

describe "Static pages" do
  describe "routing", :type => 'routing' do
    it "should be the root" do
      expect(:get => '/').to route_to('static_pages#data_options')
    end
  end

  describe "Home page" do
    it "should have links to protein and peptide" do
      visit '/'
      page { is_expected.to have_link('Proteins', href: proteins_path) }
    end
  end
end