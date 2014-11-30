require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PeptidesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Peptide. As you add validations to Peptide, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { aseq: 'aoeu',
      mod_loc: 3 }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PeptidesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET confirm delete all" do
    it "redirects to the confirm page" do
      get :confirm_delete_all, {}, valid_session
      expect(response).to render_template('confirm_delete_all')
    end
  end


  describe "DELETE all" do
    before do
      create(:peptide)
      create(:peptide, :aseq => 'SNSSNTNTSNTS', :mod_loc => 13, :nth => 5, :dataline_id => 1)
      create(:peptide, :aseq => 'CGFRGCF', :mod_loc => 13, :nth => 2, :dataline_id => 2)
    end

    it "assigns the count of proteins before deletion" do
      delete :delete_all, {}, valid_session
      expect(assigns(:peptide_count)).to eq(3)
    end

    it "deletes all the peptides" do
      expect {
        delete :delete_all, {}, valid_session
      }.to change { Peptide.count }.from(3).to(0)
    end

    it "redirects to the confirmation page" do
      delete :delete_all, {}, valid_session
      expect(response).to render_template('delete_peptides')
    end
  end


  describe "GET index" do
    it "assigns all peptides as @peptides" do
      peptide = Peptide.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:peptides)).to eq([peptide])
    end
  end

  describe "GET show" do
    it "assigns the requested peptide as @peptide" do
      peptide = Peptide.create! valid_attributes
      get :show, { :id => peptide.to_param }, valid_session
      expect(assigns(:peptide)).to eq(peptide)
    end
  end

  describe "GET new" do
    it "assigns a new peptide as @peptide" do
      get :new, {}, valid_session
      expect(assigns(:peptide)).to be_a_new(Peptide)
    end
  end

  describe "GET edit" do
    it "assigns the requested peptide as @peptide" do
      peptide = Peptide.create! valid_attributes
      get :edit, { :id => peptide.to_param }, valid_session
      expect(assigns(:peptide)).to eq(peptide)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Peptide" do
        expect {
          post :create, { :peptide => valid_attributes }, valid_session
        }.to change(Peptide, :count).by(1)
      end

      it "assigns a newly created peptide as @peptide" do
        post :create, { :peptide => valid_attributes }, valid_session
        expect(assigns(:peptide)).to be_a(Peptide)
        expect(assigns(:peptide)).to be_persisted
      end

      it "redirects to the created peptide" do
        post :create, { :peptide => valid_attributes }, valid_session
        expect(response).to redirect_to(Peptide.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved peptide as @peptide" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Peptide).to receive(:save).and_return(false)
        post :create, { :peptide => valid_attributes }, valid_session
        expect(assigns(:peptide)).to be_a_new(Peptide)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Peptide).to receive(:save).and_return(false)
        post :create, { :peptide => valid_attributes }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested peptide" do
        peptide = Peptide.create! valid_attributes
        # Assuming there are no other peptides in the database, this
        # specifies that the Peptide created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Peptide).to receive(:update_attributes).with({ 'these' => 'params' })
        put :update, { :id => peptide.to_param, :peptide => { 'these' => 'params' } }, valid_session
      end

      it "assigns the requested peptide as @peptide" do
        peptide = Peptide.create! valid_attributes
        put :update, { :id => peptide.to_param, :peptide => valid_attributes }, valid_session
        expect(assigns(:peptide)).to eq(peptide)
      end

      it "redirects to the peptide" do
        peptide = Peptide.create! valid_attributes
        put :update, { :id => peptide.to_param, :peptide => valid_attributes }, valid_session
        expect(response).to redirect_to(peptide)
      end
    end

    describe "with invalid params" do
      it "assigns the peptide as @peptide" do
        peptide = Peptide.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Peptide).to receive(:save).and_return(false)
        put :update, { :id => peptide.to_param, :peptide => {} }, valid_session
        expect(assigns(:peptide)).to eq(peptide)
      end

      it "re-renders the 'edit' template" do
        peptide = Peptide.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Peptide).to receive(:save).and_return(false)
        put :update, { :id => peptide.to_param, :peptide => {} }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested peptide" do
      peptide = Peptide.create! valid_attributes
      expect {
        delete :destroy, { :id => peptide.to_param }, valid_session
      }.to change(Peptide, :count).by(-1)
    end

    it "redirects to the peptides list" do
      peptide = Peptide.create! valid_attributes
      delete :destroy, { :id => peptide.to_param }, valid_session
      expect(response).to redirect_to(peptides_path)
    end
  end

end
