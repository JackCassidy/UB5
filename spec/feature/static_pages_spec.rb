require 'spec_helper'

describe 'Visit static pages' do

  it 'should display the page' do

    visit welcome_page_path

    expect(page).to have_content('ubiquitin')

  end
end