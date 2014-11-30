class Dataline < ActiveRecord::Base
  belongs_to :peptide_source
  has_many :peptides

  attr_accessible :tsv_string, :file_order, :peptide_source_id

  validates_presence_of :tsv_string


  # parse_peptides
  #
  # this function takes one line of spreadsheet input
  # it finds the peptide, and the location of the lysine (K) that
  # is modified with ubiquitin
  #
  # Choudhary can have two sites, with a peptide that looks like VVQKLGFPAK(1)FLDFK(1)GVTIA
  # Choudhary can also have sites to ignore, if the probability is less than 1, eg
  # ATK(1)VQDIK(0.942)NNLK
  #
  # Bennett can have leading or trailing x's, that must be removed from peptide.
  #
  def parse_peptides(parse_method, pep_col)

    @sp = self.tsv_string.split("\t")
    if @sp.length < pep_col + 1    # invalid line  #todo test this or get rid of it
      return  # no peptides here
    else
      @raw_pep = @sp[pep_col]
    end

    Peptide.one_raw_peptide(parse_method, @raw_pep, self)

  end # parse_peptides


end   # class Dataline
