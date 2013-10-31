class Peptide < ActiveRecord::Base
  attr_accessible :aseq, :mod_loc

  has_many :datalines

  validates :aseq, length: { in: 3..255 }
  validates_presence_of :aseq
  validates_presence_of :mod_loc

  def self.parse_dataline (line)     # class method

    puts "inside parse_dataline"

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

end
