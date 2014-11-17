require 'spec_helper'

describe InfilesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Infile. As you add validations to Infile, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { file_name: 'dummy_file',
                             file_size: 100,
                             first_line: 'this is the first line',
                             parse_method: 'bennett',
                             peptide_column: 5,
  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InfilesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all infiles as @infiles" do
      infile = Infile.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:infiles)).to eq([infile])
    end
  end

  describe "GET show" do
    it "assigns the requested infile as @infile" do
      infile = Infile.create! valid_attributes
      get :show, { :id => infile.to_param }, valid_session
      expect(assigns(:infile)).to eq(infile)
    end
  end

  describe "GET new" do
    before do
      create(:infile)
      create(:infile, :file_name => 'second file')
    end

    it "assigns a new infile as @infile, and all the existing infiles as @infiles" do
      get :new, {}, valid_session
      expect(assigns(:infile)).to be_a_new(Infile)
      expect(assigns(:infiles)).to eq(Infile.all)
    end
  end

  describe "GET edit" do
    it "assigns the requested infile as @infile" do
      infile = Infile.create! valid_attributes
      get :edit, { :id => infile.to_param }, valid_session
      expect(assigns(:infile)).to eq(infile)
    end
  end

  describe "GET create" do  #todo do we want or need a get for create
    before do
      create(:infile)
    end
    pending "assings the @infiles parameter" do
      get :create
      expect(assigns(:infile)).to eq(Infile.all)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/fake_peptide.txt', 'text/xml'),
                                                          :filename => 'fake_peptide.txt') }
      let(:parse_method) { 'carr' }
      let(:create_parameters) { { :file => file, :parse_method => parse_method }.merge({ "controller" => "infiles", "action" => "create" }) }


      it "saves the infile information in table and assigns it to an instance variable" do
        expect {
          post :create, create_parameters
        }.to change { Infile.count }.from(0).to(1)

        infile = Infile.last
        expect(infile.file_name).to eq('fake_peptide.txt')
        expect(infile.parse_method).to eq('carr')
        expect(infile.peptide_column).to eq(Infile.peptide_column(parse_method))
        expect(infile.first_line).to eq('Header1 H2 H3')
        expect(infile.file_size).to eq(25)

        expect(assigns(:infile)).to eq(infile)
      end


      it "redirects to create page and assigns all the infile records to the @infile variable" do
        post :create, create_parameters
        expect(response).to redirect_to(new_infile_path)
      end

      pending "test the assignment of @infiles"
    end

    pending "with invalid params -- still need to define behavior" do
      it "assigns a newly created but unsaved infile as @infile" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        post :create, { :infile => {} }, valid_session
        expect(assigns(:infile)).to be_a_new(Infile)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        post :create, { :infile => {} }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested infile" do
        infile = Infile.create! valid_attributes
        # Assuming there are no other infiles in the database, this
        # specifies that the Infile created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Infile).to receive(:update_attributes).with({ "these" => "params" })
        put :update, { :id => infile.to_param, :infile => { "these" => "params" } }, valid_session
      end

      it "assigns the requested infile as @infile" do
        infile = Infile.create! valid_attributes
        put :update, { :id => infile.to_param, :infile => valid_attributes }, valid_session
        expect(assigns(:infile)).to eq(infile)
      end

      it "redirects to the infile" do
        infile = Infile.create! valid_attributes
        put :update, { :id => infile.to_param, :infile => valid_attributes }, valid_session
        expect(response).to redirect_to(infile)
      end
    end

    describe "with invalid params" do
      it "assigns the infile as @infile" do
        infile = Infile.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        put :update, { :id => infile.to_param, :infile => {} }, valid_session
        expect(assigns(:infile)).to eq(infile)
      end

      it "re-renders the 'edit' template" do
        infile = Infile.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        put :update, { :id => infile.to_param, :infile => {} }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested infile" do
      infile = Infile.create! valid_attributes
      expect {
        delete :destroy, { :id => infile.to_param }, valid_session
      }.to change(Infile, :count).by(-1)
    end

    it "redirects to the infiles list" do
      infile = Infile.create! valid_attributes
      delete :destroy, { :id => infile.to_param }, valid_session
      expect(response).to redirect_to(infiles_path)
    end
  end

end
