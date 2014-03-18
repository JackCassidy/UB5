class InfilesController < ApplicationController


  # POST new_protein_file
  def new_protein_file
    @infile = Infile.new()
  end

  # GET /infiles
  # GET /infiles.json
  def index
    @infiles = Infile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @infiles }
    end
  end

  # GET /infiles/1
  # GET /infiles/1.json
  def show
    @infile = Infile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @infile }
    end
  end

  # GET /infiles/new
  # GET /infiles/new.json
  def new
    @infile = Infile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @infile }
    end
  end

  # GET /infiles/1/edit
  def edit
    @infile = Infile.find(params[:id])
  end

  # POST /infiles
  # POST /infiles.json
  def create
    @infile = Infile.new(params[:infile])

    respond_to do |format|
      if @infile.save
        format.html { redirect_to @infile, notice: 'Infile was successfully created.' }
        format.json { render json: @infile, status: :created, location: @infile }
      else
        format.html { render action: "new" }
        format.json { render json: @infile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /infiles/1
  # PUT /infiles/1.json
  def update
    @infile = Infile.find(params[:id])

    respond_to do |format|
      if @infile.update_attributes(params[:infile])
        format.html { redirect_to @infile, notice: 'Infile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @infile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infiles/1
  # DELETE /infiles/1.json
  def destroy
    @infile = Infile.find(params[:id])
    @infile.destroy

    respond_to do |format|
      format.html { redirect_to infiles_url }
      format.json { head :no_content }
    end
  end
end
