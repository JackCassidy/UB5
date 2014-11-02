require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
#itdemonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
#itassumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
#itonly uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PeptideProteinsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # PeptideProtein. As you add validations to PeptideProtein, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { peptide_id: "1",
                             protein_id: "1",
                             protein_mod_site: 3 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PeptideProteinsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "POST match" do

    context "when there is a single peptide, protein and match" do
      let!(:peptide_i) { create(:peptide, :aseq => 'III') }
      let!(:protein_1) { create(:protein, :aa_sequence => 'IIIYMMMMMMMMMYAGGGMMMM') } # one existing and one new match

      it "finds the match and writes the record" do
        post :matcher, {}, valid_session

        expect(PeptideProtein.count).to eq(1)
        expect(PeptideProtein.first[:protein_mod_site]).to eq(0)
      end
    end


    context "when there are multiple matches" do
      let!(:peptide_i) { create(:peptide, :aseq => 'III') }
      let!(:peptide_v) { create(:peptide, :aseq => 'VVVVV') }
      let!(:peptide_g) { create(:peptide, :aseq => 'GGG') } # no match
      let!(:protein_1) { create(:protein, :aa_sequence => 'IIIYMMMMMMMMMYAGGGMMMM') } # one existing and one new match
      let!(:protein_2) { create(:protein, :aa_sequence => 'VVVVVMMMMMMVVVVVMMMM') } # two of the same peptide in the same protein
      let!(:protein_3) { create(:protein, :aa_sequence => 'KKKKKKKKKKKKKKKKKKKKKGGGKGGGFGFGFGKKKKK') } # two matches

      before do
        create(:peptide_protein, protein_id: protein_1.id, peptide_id: peptide_i.id, protein_mod_site: 1) #existing match that is in the current data set
      end

      it "for every peptide, finds all matches in any protein" do
        expect { post :matcher }.to change { PeptideProtein.count }
      end
    end

  end

  describe "GET index" do
    it "assigns all peptide_proteins as @peptide_proteins" do
      peptide_protein = PeptideProtein.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:peptide_proteins)).to eq([peptide_protein])
    end
  end

  describe "GET show" do
    it "assigns the requested peptide_protein as @peptide_protein" do
      peptide_protein = PeptideProtein.create! valid_attributes
      get :show, { :id => peptide_protein.to_param }, valid_session
      expect(assigns(:peptide_protein)).to eq(peptide_protein)
    end
  end

  describe "GET new" do
    it "assigns a new peptide_protein as @peptide_protein" do
      get :new, {}, valid_session
      expect(assigns(:peptide_protein)).to be_a_new(PeptideProtein)
    end
  end

  describe "GET edit" do
    it "assigns the requested peptide_protein as @peptide_protein" do
      peptide_protein = PeptideProtein.create! valid_attributes
      get :edit, { :id => peptide_protein.to_param }, valid_session
      expect(assigns(:peptide_protein)).to eq(peptide_protein)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new PeptideProtein" do
        expect {
          post :create, { :peptide_protein => valid_attributes }, valid_session
        }.to change(PeptideProtein, :count).by(1)
      end

      it "assigns a newly created peptide_protein as @peptide_protein" do
        post :create, { :peptide_protein => valid_attributes }, valid_session
        expect(assigns(:peptide_protein)).to be_a(PeptideProtein)
        expect(assigns(:peptide_protein)).to be_persisted
      end

      it "redirects to the created peptide_protein" do
        post :create, { :peptide_protein => valid_attributes }, valid_session
        expect(response).to redirect_to(PeptideProtein.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved peptide_protein as @peptide_protein" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PeptideProtein).to receive(:save).and_return(false)
        post :create, { :peptide_protein => { "peptide_id" => "invalid value" } }, valid_session
        expect(assigns(:peptide_protein)).to be_a_new(PeptideProtein)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PeptideProtein).to receive(:save).and_return(false)
        post :create, { :peptide_protein => { "peptide_id" => "invalid value" } }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested peptide_protein" do
        peptide_protein = PeptideProtein.create! valid_attributes
        # Assuming there are no other peptide_proteins in the database, this
        # specifies that the PeptideProtein created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(PeptideProtein).to receive(:update_attributes).with({ "peptide_id" => "1" })
        put :update, { :id => peptide_protein.to_param, :peptide_protein => { "peptide_id" => "1" } }, valid_session
      end

      it "assigns the requested peptide_protein as @peptide_protein" do
        peptide_protein = PeptideProtein.create! valid_attributes
        put :update, { :id => peptide_protein.to_param, :peptide_protein => valid_attributes }, valid_session
        expect(assigns(:peptide_protein)).to eq(peptide_protein)
      end

      it "redirects to the peptide_protein" do
        peptide_protein = PeptideProtein.create! valid_attributes
        put :update, { :id => peptide_protein.to_param, :peptide_protein => valid_attributes }, valid_session
        expect(response).to redirect_to(peptide_protein)
      end
    end

    describe "with invalid params" do
      it "assigns the peptide_protein as @peptide_protein" do
        peptide_protein = PeptideProtein.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PeptideProtein).to receive(:save).and_return(false)
        put :update, { :id => peptide_protein.to_param, :peptide_protein => { "peptide_id" => "invalid value" } }, valid_session
        expect(assigns(:peptide_protein)).to eq(peptide_protein)
      end

      it "re-renders the 'edit' template" do
        peptide_protein = PeptideProtein.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PeptideProtein).to receive(:save).and_return(false)
        put :update, { :id => peptide_protein.to_param, :peptide_protein => { "peptide_id" => "invalid value" } }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested peptide_protein" do
      peptide_protein = PeptideProtein.create! valid_attributes
      expect {
        delete :destroy, { :id => peptide_protein.to_param }, valid_session
      }.to change(PeptideProtein, :count).by(-1)
    end

    it "redirects to the peptide_proteins list" do
      peptide_protein = PeptideProtein.create! valid_attributes
      delete :destroy, { :id => peptide_protein.to_param }, valid_session
      expect(response).to redirect_to(peptide_proteins_path)
    end
  end

end
