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
      get :show, {:id => infile.to_param}, valid_session
      expect(assigns(:infile)).to eq(infile)
    end
  end

  describe "GET new" do
    it "assigns a new infile as @infile" do
      get :new, {}, valid_session
      expect(assigns(:infile)).to be_a_new(Infile)
    end
  end

  describe "GET edit" do
    it "assigns the requested infile as @infile" do
      infile = Infile.create! valid_attributes
      get :edit, {:id => infile.to_param}, valid_session
      expect(assigns(:infile)).to eq(infile)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let!(:up_file) { ActionDispatch::Http::UploadedFile.new(:tempfile => fixture_file_upload('/tiny_carr.tsv', 'text/xml'),
                                                              :filename => 'tiny_carr.tsv') }

      it "creates a new Infile with the right values" do
        expect {
          post :create, {infile: up_file}, valid_session
        }.to change(Infile, :count).by(1)

        infile = Infile.last
        expect(infile[:file_name]).to eq('tiny_carr.tsv')
        expect(infile[:file_size]).to eq(6547)
        expect(infile[:parse_method]).to eq('carr')
        expect(infile[:peptide_column]).to eq(3)
        expect(infile[:first_line]).to eq("Unmodified peptide\tK-ε-GG Site [nd=K-ε-GG localization identifier <0.5]\tNterm_Acetylation on peptide True or False?\tModified Peptide (Sequence Input for Viewer; for peptides with >1 K-ε-GG site having a localization identifier of 0.5, the K-ε-GG site was placed on the first of the two lysine residues for the viewer; k=K-ε-GG site, m=methionine oxidation, n=asparagine deamidation)\tScan Number shown in Viewer\tCharge State of Precursor Shown in Veiwer\tm/z of Precursor Shown in Viewer\tAndromeda Score of MS/MS Scan Shown in Viewer\t\t\"Length of URLin link\"\t\tLeading Proteins\tGene Names\tProtein Names\tProtein Descriptions\tUniprot\tExperiment\tExpt1Rep1 (K-ε-GG Peptide Identified True or False?)\tExpt1Rep2 (K-ε-GG Peptide Identified True or False?)\tExpt2Rep1 (K-ε-GG Peptide Identified True or False?)\tExpt2Rep2 (K-ε-GG Peptide Identified True or False?)\tExpt1Rep1_Unfractionated (K-ε-GG Peptide Identified True or False?)\tExpt1Rep1_Fractionated (K-ε-GG Peptide Identified True or False?)\tExpt2Rep1_Unfractionated (K-ε-GG Peptide Identified True or False?) \tExpt2Rep1_Fractionated (K-ε-GG Peptide Identified True or False?)\tExpt2Rep2_Unfractionated (K-ε-GG Peptide Identified True or False?)\tExpt2Rep2_Fractionated (K-ε-GG Peptide Identified True or False?)\tRep1 SILAC Log2 Ratio 5uM MG-132/0.5% DMSO (H/L)\tRep2 SILAC Log2 Ratio 5uM MG-132/0.5% DMSO (L/M)\tRep1 SILAC Log2 Ratio 5uM PR-619/0.5% DMSO (M/L)\tRep2 SILAC Log2 Ratio 5uM PR-619/0.5% DMSO (H/M)\tRep1 SILAC Log2 Ratio 17uM PR-619/0.5% DMSO (M/L)\tRep2 SILAC Log2 Ratio 17uM PR-619/0.5% DMSO (H/M)\tRep1 SILAC Log2 Ratio 17uM PR-619 & 5uM MG-132/0.5% DMSO (H/L)\tRep2 SILAC Log2 Ratio 17uM PR-619 & 5uM MG-132/0.5% DMSO (L/M)")
      end

      it "assigns a newly created infile as @infile" do
        post :create, {:infile => up_file}, valid_session
        expect(assigns(:infile)).to be_a(Infile)
        expect(assigns(:infile)).to be_persisted
      end

      it "redirects to the created infile" do
        post :create, {:infile => up_file}, valid_session
        expect(response).to redirect_to(Infile.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved infile as @infile" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        post :create, {:infile => {  }}, valid_session
        expect(assigns(:infile)).to be_a_new(Infile)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        post :create, {:infile => {  }}, valid_session
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
        put :update, {:id => infile.to_param, :infile => { "these" => "params" }}, valid_session
      end

      it "assigns the requested infile as @infile" do
        infile = Infile.create! valid_attributes
        put :update, {:id => infile.to_param, :infile => valid_attributes}, valid_session
        expect(assigns(:infile)).to eq(infile)
      end

      it "redirects to the infile" do
        infile = Infile.create! valid_attributes
        put :update, {:id => infile.to_param, :infile => valid_attributes}, valid_session
        expect(response).to redirect_to(infile)
      end
    end

    describe "with invalid params" do
      it "assigns the infile as @infile" do
        infile = Infile.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        put :update, {:id => infile.to_param, :infile => {  }}, valid_session
        expect(assigns(:infile)).to eq(infile)
      end

      it "re-renders the 'edit' template" do
        infile = Infile.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Infile).to receive(:save).and_return(false)
        put :update, {:id => infile.to_param, :infile => {  }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested infile" do
      infile = Infile.create! valid_attributes
      expect {
        delete :destroy, {:id => infile.to_param}, valid_session
      }.to change(Infile, :count).by(-1)
    end

    it "redirects to the infiles list" do
      infile = Infile.create! valid_attributes
      delete :destroy, {:id => infile.to_param}, valid_session
      expect(response).to redirect_to(infiles_path)
    end
  end

end
