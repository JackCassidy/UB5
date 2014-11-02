class PeptideProteinsController < ApplicationController

  def parsimony
    render :parsimony
  end

  # POST matcher
  def matcher

  end

  # GET /peptide_proteins
  # GET /peptide_proteins.json
  def index
    @peptide_proteins = PeptideProtein.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @peptide_proteins }
    end
  end

  # GET /peptide_proteins/1
  # GET /peptide_proteins/1.json
  def show
    @peptide_protein = PeptideProtein.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @peptide_protein }
    end
  end

  # GET /peptide_proteins/new
  # GET /peptide_proteins/new.json
  def new
    @peptide_protein = PeptideProtein.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @peptide_protein }
    end
  end

  # GET /peptide_proteins/1/edit
  def edit
    @peptide_protein = PeptideProtein.find(params[:id])
  end

  # POST /peptide_proteins
  # POST /peptide_proteins.json
  def create
    @peptide_protein = PeptideProtein.new(params[:peptide_protein])

    respond_to do |format|
      if @peptide_protein.save
        format.html { redirect_to @peptide_protein, notice: 'Peptide protein was successfully created.' }
        format.json { render json: @peptide_protein, status: :created, location: @peptide_protein }
      else
        format.html { render action: "new" }
        format.json { render json: @peptide_protein.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /peptide_proteins/1
  # PUT /peptide_proteins/1.json
  def update
    @peptide_protein = PeptideProtein.find(params[:id])

    respond_to do |format|
      if @peptide_protein.update_attributes(params[:peptide_protein])
        format.html { redirect_to @peptide_protein, notice: 'Peptide protein was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @peptide_protein.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /peptide_proteins/1
  # DELETE /peptide_proteins/1.json
  def destroy
    @peptide_protein = PeptideProtein.find(params[:id])
    @peptide_protein.destroy

    respond_to do |format|
      format.html { redirect_to peptide_proteins_url }
      format.json { head :no_content }
    end
  end
end
