class Peptide < ActiveRecord::Base
  attr_accessible :aseq, :mod_loc, :nth, :searched, :dataline_id
  attr_accessor :peptide_file

  belongs_to :dataline
  has_many :peptide_proteins
  has_many :proteins, through: :peptide_proteins

  validates :aseq, length: { in: 3..255 }
  validates_presence_of :aseq
  validates_presence_of :mod_loc


  #
  # parse_peptide_file
  # We have a file and a parse method.
  # Read the file's datalines, and parse those datalines
  #
  def parse_peptide_file(peptide_file=nil, format=nil)
    peptide_file = self.peptide_file if peptide_file.nil?
    format = 'carr' if format.nil?

    pep_infile = Infile.read_data_file(peptide_file, format)

    peptide_col =  Dataline.look_up_peptide_column(format)
    pep_infile.datalines.each do |dat|
      dat.parse_peptides(format, peptide_col)
    end

  end


  #
  # make_new_peptide
  # We've parsed out the modified lysine, and converted the peptide
  # string into all capital letter aa's.
  # Now create a new peptide for the database.
  #
  def self.make_new_peptide(final_pep, ml, dataline, nth)

    return if /[^A-Z]/.match(final_pep)
    return unless final_pep[ml] == 'K'

    @pep = Peptide.new
    @pep.aseq = final_pep
    @pep.mod_loc = ml
    @pep.nth = nth
    @pep.searched = false
    @pep.dataline_id = dataline.id

    @pep.save if @pep.valid?  # put this in db

  end   # make_new_peptide

  #
  # one_raw_peptide
  # Parse the peptide according to parse method.
  # Create new peptide(s) for database.
  #
  # The K (lysine) that we find, is where the ubiquitination
  # occurs in the peptide.
  #
  def self.one_raw_peptide(parse_method, raw_pep, dataline)

    # carr string has a lowercase k, like ABCDkEFG, but sometimes nothing
    if parse_method == 'carr'
      @ml = raw_pep.index('k')
      return -1, 'INVALID_PEPTIDE_CARR' if @ml.nil?
      @final_pep = raw_pep.upcase
      Peptide.make_new_peptide(@final_pep, @ml, dataline, 1)


    # bennett string has K in the middle
    # but might have leading or trailing x's
    elsif parse_method == 'bennett'
      @ml = raw_pep.length / 2
      return -1, 'INVALID_PEPTIDE_BENNETT' if raw_pep[@ml] != 'K'
      @final_pep = raw_pep

      # get rid of x's at beginning, if any
      while @final_pep[0] == 'x' do
        @final_pep = @final_pep[1..-1]
        @ml = @ml - 1
      end
      # get rid of x's at end, if any
      @final_pep.gsub!(/x/, '')

      Peptide.make_new_peptide(@final_pep, @ml, dataline, 1)


    # choudhary has zero or more K(1)'s
    # may have some less than 1's to ignore
    # example: ABCK(1)DEF(0.947)HIJK(1)LMN
    elsif parse_method == 'choudhary'

      # remove non-certainty, less than 1 items
      @work_pep = raw_pep.gsub(/\(0.*?\)/, '')

      # may be multiple K(1)'s
      @nth = 0
      while @work_pep.index('(1)')
        @ml = @work_pep.index('(1)')
        @ml = @ml - 1       # K comes right before (1)
        @work_pep = @work_pep[0..@ml].concat(@work_pep[@ml+4..-1]) # eliminate one (1)
        @final_pep = @work_pep.gsub(/\(1\)/, '')    # get rid of all (1)'s
        @nth += 1
        Peptide.make_new_peptide(@final_pep, @ml, dataline, @nth)
      end


    else
      # this shouldn't happen, if it does, we want to know
      puts dataline.file_order.to_s
      puts dataline
      exit("** Unrecognized parse method #{parse_method} **")

    end  # if parse_method

  end   # one_raw_peptide


  #
  # We have a peptide.
  # Search the protein database for strings containing this peptide.
  # There may be zero or many.
  # For each protein match, create a link through this peptide's datalines.
  #
  # Original version assumes all data loading takes place at one time.
  # Will probably want to be able to add data files incrementally, just
  # dealing new datalines.
  #

  def find_my_proteins

    return -1 if self.searched  # don't re-do what we've done

    #
    # SQL query to find matching proteins
    pros = Protein.where("aa_sequence LIKE '%#{self.aseq}%'")

    return 0 if pros.empty?

    #
    # there were one or more found
    #
    pros.all.each do |pro|

      @pp = PeptideProtein.new

      @pp.peptide_id = self.id
      @pp.protein_id = pro.id

      first_loc = pro.aa_sequence.index(self.aseq)
      @pp.protein_mod_site = first_loc + self.mod_loc

      @pp.save if @pp.valid?

      pro.peptide_proteins << @pp
      self.peptide_proteins << @pp

    end   # each protein found

    return pros.count

  end   # find_my_proteins



  # this function finds and returns all the peptides that
  # were not found in a protein
  #
  # we want to see
  # - the spreadsheet it came from
  # - the IPI number
  # - the sequence
  #
  def self.unaffiliated_peptides

    infile_names = ['bennett', 'carr', 'choudhary']

    @unaffiliated = []
    Peptide.all.each do |pep|

      if pep.proteins.count == 0
        if pep.dataline_id
          @dat = Dataline.find(pep.dataline_id)
          in_index = @dat.infile_id - 1
          in_name = infile_names[in_index]
          full_string = @dat.tsv_string
          first_ipi_at = full_string.index('IPI')
          suffix = full_string[first_ipi_at..-1]
          ipi_string = suffix.split[0]
          triple = [in_name, ipi_string, pep.aseq]
        else
          triple = ['unk', 'unk', pep.aseq]
        end   # if dataline

        @unaffiliated << triple
      end  # if

    end  # each

    return @unaffiliated

  end  # unaffiliated_peptides


end   # class Peptide
