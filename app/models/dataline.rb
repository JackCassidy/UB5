class Dataline < ActiveRecord::Base
  belongs_to :infile
  has_many :peptides

  attr_accessible :tsv_string, :file_order, :infile_id

  #
  # for each parse method, where in line to look for raw peptide
  #
  def self.look_up_peptide_column(parse_method)

    if parse_method == 'carr'
      return 3        # lower case k
    elsif parse_method == 'bennett'
      return 5        # middle character K
    elsif parse_method == 'choudhary'
      return 13       # K(1), a probability measure
    else
      abort("** Unrecognized parse method #{parse_method} **") #todo do something better than abort here
    end

  end  # look_up_peptide_column


  # parse_peptides
  #
  # this function takes one line of spreadsheet input
  # it finds the peptide, and the location of the lysine (K) that
  # is modified with ubiquitin
  #
  # Method may be called multiple times, to parse the first or second
  # site.
  # Choudhary can have two sites, with a peptide that looks like VVQKLGFPAK(1)FLDFK(1)GVTIA
  # Choudhary can also have sites to ignore, if the probability is less than 1, eg
  # ATK(1)VQDIK(0.942)NNLK
  #
  # Bennett can have leading or trailing x's, that must be removed from peptide.
  #
  def parse_peptides(parse_method, pep_col)

    @sp = self.tsv_string.split("\t")
    if @sp.length < pep_col + 1    # invalid line
      return  # no peptides here
    else
      @raw_pep = @sp[pep_col]
    end

    Peptide.one_raw_peptide(parse_method, @raw_pep, self)

  end # parse_peptides


end   # class Dataline
