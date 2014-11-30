class PeptideSourcesController < ApplicationController

  # GET /peptide_sources
  # GET /peptide_sources.json
  def index
    @peptide_sources = PeptideSource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @peptide_sources }
    end
  end

  # GET /peptide_sources/1
  # GET /peptide_sources/1.json
  def show
    @peptide_source = PeptideSource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @peptide_source }
    end
  end

  # GET /peptide_sources/new
  # GET /peptide_sources/new.json
  def new
    @peptide_source = PeptideSource.new
    @peptide_sources = PeptideSource.all


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @peptide_source }
    end
  end

  # POST /peptide_sources
  # POST /peptide_sources.json
  def create
    save_file

    file_parameters = PeptideSource.parameters_from_temp_file(params[:file])
    peptide_column = { :peptide_column => PeptideSource.peptide_column(params['parse_method']) }
    parse_method = { :parse_method => params['parse_method'] }
    to_be_uploaded = { :to_be_uploaded => true }
    record_parameters = parse_method.merge(file_parameters).merge(peptide_column).merge(to_be_uploaded)

    peptide_source = PeptideSource.new(record_parameters)
    peptide_source.save!
    @peptide_source = peptide_source

    @peptide_sources = PeptideSource.all

    respond_to do |format|
      if @peptide_source.save
        format.html { redirect_to new_peptide_source_path, notice: 'PeptideSource was successfully created.' }
        format.json { render json: @peptide_source, status: :created, location: @peptide_source }
      else
        format.html { render action: "new" }
        format.json { render json: @peptide_source.errors, status: :unprocessable_entity }
      end
    end
  end

  def select_file_to_parse
    @peptide_sources = PeptideSource.all
  end

   def extract_peptides_from_source
     @file_name = params['file_name']
     @peptides_before = Peptide.count

     PeptideSource.read_data_file(params['file_name'])

     @peptides_after = Peptide.count
   end


end

private

def save_file
  save_path = UB5::Application.config.peptide_source_path
  file = params[:file]
  file_name = File.join(save_path, file.original_filename)

  FileUtils.mv file.tempfile.path, file_name
end


