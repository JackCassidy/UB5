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
  def self.parse_dataline (line)     # class method

    # make sure line has at least 3 tabs
    line.chomp!
    sp = line.split("\t")
    if sp.length < 4
      return
    else
      raw_pep = sp[3]
      first_word = sp[0]
    end

    # check for header tab, not a peptide, or no lysine mod
    return if first_word == 'Unmodified peptide'    # &&& diff formats
    return if /[^a-zA-Z]/.match(raw_pep)   # peptide should be all alphabetic
    ml = raw_pep.index('k')
    return if ml.nil?

    @peptide = Peptide.new
    @peptide.mod_loc = ml
    @peptide.aseq = raw_pep.upcase

    @dataline = Dataline.new
    @dataline.tsv_string = line

    # check for peptide already in db
    old_p = Peptide.find_by_aseq(@peptide.aseq)
    if !old_p.nil? and old_p.mod_loc == ml
      # already exists, add dataline
      old_p.datalines << @dataline
      old_p.save
    else
      # first time for this one
      @peptide.datalines << @dataline
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

end   # class Peptide
