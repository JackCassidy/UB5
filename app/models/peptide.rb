class Peptide < ActiveRecord::Base
  attr_accessible :aseq, :mod_loc

  has_many :datalines
  has_many :proteins, through: :datalines

  validates :aseq, length: { in: 3..255 }
  validates_presence_of :aseq
  validates_presence_of :mod_loc


  #
  # this function takes one line of spreadsheet input
  # it finds the peptide, and the location of the lysine that
  # is modified with ubiquitin
  #
  # First version assumes Carr lab format. Needs to change format
  # for other layouts.
  #
  def self.parse_dataline (dataline_in, parse_method)     # class method

    line = dataline_in.tsv_string
    parse_method.chomp!       # in case of trailing line feed

    pep_col = self.look_up_peptide_column(parse_method)

    # make sure line has at enough tabs, retrieve raw peptide
    line.chomp!
    sp = line.split("\t")
    if sp.length < pep_col + 1    # invalid line
      return
    else
      raw_pep = sp[pep_col]
    end

    # parse the peptide, making it all cap letters, and giving mod loc
    ml, final_pep = self.parse_peptide(raw_pep, parse_method)

    # if nothing was found, skip this line
    return if ml < 0


    @peptide = Peptide.new
    @peptide.mod_loc = ml
    @peptide.aseq = final_pep

    # check for peptide already in db
    old_p = Peptide.find_by_aseq(@peptide.aseq)
    if !old_p.nil? and old_p.mod_loc == ml
      # already exists, add dataline
      old_p.datalines << dataline_in
      old_p.save
    else
      # first time for this one
      @peptide.datalines << dataline_in
      @peptide.save
    end
  end


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

    #
    # SQL query to find matching proteins
    pros = Protein.where("aa_sequence LIKE '%#{self.aseq}%'")

    return 0 if pros.empty?

    #
    # there were one or more found
    #
    pros.all.each do |pro|

      # the peptide can have multiple datalines, differing
      # in the peptide mod_loc
      # each dataline gives a protein modification location and
      # should document a peptide/protein relationship
      self.datalines.each do |dat|
        first_loc = pro.aa_sequence.index(self.aseq)
        dat.protein_modification_location = first_loc + self.mod_loc
        pro.datalines << dat
      end   # each dataline
    end   # each protein found

    return pros.count

  end   # find_my_proteins


  def self.look_up_peptide_column(parse_method)

    if parse_method == 'carr'
      return 3        # lower case k
    elsif parse_method == 'bennett'
      return 5        # middle character K
    elsif parse_method == 'choudhary'
      return 13       # K(1), a probability measure
    else
      abort("** Unrecognized parse method #{parse_method} **")
    end

  end  # look_up_peptide_column

  #
  # For a peptide from a data file, figure out where the modification
  # (ubiquitin attachment) is. Only pay attention to modified lysine,
  # and, for Choudhary, only those with a probability of 1.
  #
  # Return the modification location, and the peptide as a string
  # of uppercase characters only.
  #
  def self.parse_peptide(raw_pep, parse_method)

    # carr string looks like ABCDEkYZ, but may not have a 'k'
    if parse_method == 'carr'
      ml = raw_pep.index('k')
      final_pep = raw_pep.upcase
      return -1, 'INVALID_PEPTIDE_CARR' if ml.nil?
      return ml, final_pep

    # bennett string looks like ABCKXYZ, always K as middle character
    elsif parse_method == 'bennett'
      ml = raw_pep.length / 2
      final_pep = raw_pep
      return -1, 'INVALID_PEPTIDE_BENNETT' if final_pep[ml] != 'K'
      return ml, final_pep

    # choudhary string looks like ABCK(1)YZ, or ABCK(0.5)WXK(0.5)YZ
    elsif parse_method == 'choudhary'
      paren_at = raw_pep.index('(1)')
      return -1, 'INVALID_PEPTIDE_CHOUDHARY' if paren_at.nil?
      ml = paren_at - 1
      return -1, 'INVALID_PEPTIDE_CHOUDHARY' if raw_pep[ml] != 'K'
      final_pep = raw_pep[0..ml]
      final_pep.concat(raw_pep[ml+4..-1])
      return ml, final_pep

    else
      exit("** Unrecognized parse method #{parse_method} **")
    end

  end


end   # class Peptide
