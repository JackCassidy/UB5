require 'spec_helper'
require 'factory_girl'

describe "Protein search page" do
  let(:protein) { create(:protein)  }

  it "shows a search box" do
    visit proteins_path
    expect(page).to have_content "Enter word from protein description"

    fill_in "Protein description", with: "ENDOV"
    click "submit"
    expect(page).to have_content "HUMAN"
  end
end



