require 'spec_helper'

describe PeptideSourcesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # PeptideSource. As you add validations to PeptideSource, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { file_name: 'dummy_file',
                             file_size: 100,
                             first_line: 'this is the first line',
                             parse_method: 'bennett',
                             peptide_column: 5,
                             to_be_uploaded: true,
  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PeptideSourcesController. Be sure to keep this updated too.

  describe "GET index" do
    it "assigns all peptide_sources as @peptide_sources" do
      peptide_source = PeptideSource.create! valid_attributes
      get :index
      expect(assigns(:peptide_sources).last).to eq(peptide_source)
    end
  end

  describe "GET show" do
    it "assigns the requested peptide_source as @peptide_source" do
      peptide_source = PeptideSource.create! valid_attributes
      get :show, { :id => peptide_source.to_param }
      expect(assigns(:peptide_source)).to eq(peptide_source)
    end
  end

  describe "GET new" do
    before do
      create(:peptide_source)
      create(:peptide_source, :file_name => 'second file')
    end

    it "assigns a new peptide_source as @peptide_source, and all the existing peptide_sources as @peptide_sources" do
      get :new
      expect(assigns(:peptide_source)).to be_a_new(PeptideSource)
      expect(assigns(:peptide_sources)).to eq(PeptideSource.all)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/fake_peptide.txt', 'text/xml'),
                                                          :filename => 'fake_peptide.txt') }
      let(:parse_method) { 'carr' }
      let(:create_parameters) { { :file => file, :parse_method => parse_method }.merge({ "controller" => "peptide_sources", "action" => "create" }) }


      it "saves the peptide_source information in table and assigns it to an instance variable" do
        expect {
          post :create, create_parameters
        }.to change { PeptideSource.count }.from(0).to(1)

        peptide_source = PeptideSource.last
        expect(peptide_source.file_name).to eq('fake_peptide.txt')
        expect(peptide_source.parse_method).to eq('carr')
        expect(peptide_source.peptide_column).to eq(3)
        expect(peptide_source.first_line).to eq('Header1 H2 H3')
        expect(peptide_source.file_size).to eq(25)
        expect(peptide_source.to_be_uploaded).to eq(true)

        expect(assigns(:peptide_source)).to eq(peptide_source)
      end

      it "saves the file locally" do
        expect_any_instance_of(PeptideSourcesController).to receive(:save_file)
        post :create, create_parameters
      end


      it "redirects to create page and assigns all the peptide_source records to the @peptide_source variable" do
        post :create, create_parameters
        expect(response).to redirect_to(new_peptide_source_path)
      end
    end
  end
end
