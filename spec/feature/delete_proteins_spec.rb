require 'spec_helper'

describe 'delete proteins' do
  before do
    create(:protein)
    create(:protein, :sp_or_tr => 'tr', :accession => 'A Number', :description => "I'm a description", :aa_sequence => 'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE')
  end

  it 'should tell how many are going to be deleted' do
    expect(Protein.count).to eq(2)

    visit pages_data_options_path
    click_on 'Delete proteins'

    expect(page).to have_content('2 proteins')
  end

  it 'deletes all the proteins and confirms that it was done' do
    expect(Protein.count).to eq(2)

    visit pages_data_options_path
    click_on 'Delete proteins'

    expect(page).to have_content('Are you sure')
    click_on 'Delete all proteins'

    expect(page).to have_content('All 2 proteins have been deleted from the database')
    expect(Protein.count).to eq(0)
  end
end