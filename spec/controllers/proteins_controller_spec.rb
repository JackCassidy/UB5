require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# xit demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# xit assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# xit only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ProteinsController do

  # This should return the minimal set of attributes required to create a valid
  # Protein. As you add validations to Protein, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {sp_or_tr: 'sp',
     accession: 'some accession string',
     description: "this can be real long and have special symbols, #'s, etc.'!",
     aa_sequence: 'AAAA BBBB?'}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProteinsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET load proteins page" do
    it "renders the load proteins template" do
      get :select_file
      expect(response.status).to eq(200)
      expect(response).to render_template('select_fasta_file')
    end
  end

  describe "POST load proteins page" do
    let!(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/tiny.fasta', 'text/xml'),
                                                        :filename => 'tiny.fasta') }

    before do
      Protein.stub(:parse_fasta_file)
    end

    it "calls parse_fasta_file with the contents of the file" do
      post :upload, :fasta_file => file
      expect(response).to render_template('upload')
    end
    it "updates the database with the proteins from the uploaded file" do
      expect(Protein.count).to eq(0)
      post :upload, :fasta_file => file
      expect(Protein.count).to eq(10)
    end
  end





  describe "GET index" do
    it "assigns all proteins as @proteins" do
      protein = Protein.create! valid_attributes
      get :index, {}, valid_session
      assigns(:proteins).should eq([protein])
    end
  end

  describe "GET show" do
      it "assigns the requested protein as @protein" do
        protein = Protein.create! valid_attributes
        get :show, {:id => protein.to_param}, valid_session
        assigns(:protein).should eq(protein)
      end
    end

    describe "GET new" do
      it "assigns a new protein as @protein" do
        get :new, {}, valid_session
        assigns(:protein).should be_a_new(Protein)
      end
    end

    describe "GET edit" do
      it "assigns the requested protein as @protein" do
        protein = Protein.create! valid_attributes
        get :edit, {:id => protein.to_param}, valid_session
        assigns(:protein).should eq(protein)
      end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Protein" do
        expect {
          post :create, {:protein => valid_attributes}, valid_session
        }.to change(Protein, :count).by(1)
      end

      it "assigns a newly created protein as @protein" do
        post :create, {:protein => valid_attributes}, valid_session
        assigns(:protein).should be_a(Protein)
        assigns(:protein).should be_persisted
      end

      it "redirects to the created protein" do
        post :create, {:protein => valid_attributes}, valid_session
        response.should redirect_to(Protein.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved protein as @protein" do
        # Trigger the behavior that occurs when invalid params are submitted
        Protein.any_instance.stub(:save).and_return(false)
        post :create, {:protein => {}}, valid_session
        assigns(:protein).should be_a_new(Protein)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Protein.any_instance.stub(:save).and_return(false)
        post :create, {:protein => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested protein" do
        protein = Protein.create! valid_attributes
        # Assuming there are no other proteins in the database, this
        # specifies that the Protein created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Protein.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => protein.to_param, :protein => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested protein as @protein" do
        protein = Protein.create! valid_attributes
        put :update, {:id => protein.to_param, :protein => valid_attributes}, valid_session
        assigns(:protein).should eq(protein)
      end

      it "redirects to the protein" do
        protein = Protein.create! valid_attributes
        put :update, {:id => protein.to_param, :protein => valid_attributes}, valid_session
        response.should redirect_to(protein)
      end
    end

    describe "with invalid params" do
      it "assigns the protein as @protein" do
        protein = Protein.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Protein.any_instance.stub(:save).and_return(false)
        put :update, {:id => protein.to_param, :protein => {}}, valid_session
        assigns(:protein).should eq(protein)
      end

      it "re-renders the 'edit' template" do
        protein = Protein.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Protein.any_instance.stub(:save).and_return(false)
        put :update, {:id => protein.to_param, :protein => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested protein" do
      protein = Protein.create! valid_attributes
      expect {
        delete :destroy, {:id => protein.to_param}, valid_session
      }.to change(Protein, :count).by(-1)
    end

    it "redirects to the proteins list" do
      protein = Protein.create! valid_attributes
      delete :destroy, {:id => protein.to_param}, valid_session
      response.should redirect_to(proteins_path)
    end
  end

end
