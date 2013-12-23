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
  # Method may be called multiple times, to parse the first or second
  # site.
  # Choudhary can have two sites, with a peptide that looks like VVQKLGFPAK(1)FLDFK(1)GVTIA
  # Choudhary can also have sites to ignore, if the probability is less than 1, eg
  # ATK(1)VQDIK(0.942)NNLK   In this case, use the first site, ignore the second.
  #
  def self.parse_dataline (dataline_in, parse_method, nth)     # class method

    b_two_sites = false

    line = dataline_in.tsv_string
    parse_method.chomp!       # in case of trailing line feed

    pep_col = self.look_up_peptide_column(parse_method)

    # make sure line has at enough tabs, retrieve raw peptide
    line.chomp!
    sp = line.split("\t")
    if sp.length < pep_col + 1    # invalid line
      return b_two_sites
    else
      raw_pep = sp[pep_col]
    end

    # parse the peptide, making it all cap letters, and giving mod loc
    ml, final_pep, b_two_sites = self.parse_peptide(raw_pep, parse_method, nth)

    # if nothing was found, skip this line
    return b_two_sites if ml < 0


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

    return b_two_sites

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
  def self.parse_peptide(raw_pep, parse_method, nth)

    come_back = false

    # carr string looks like ABCDEkYZ, but may not have a 'k'
    if parse_method == 'carr'
      ml = raw_pep.index('k')
      final_pep = raw_pep.upcase
      return -1, 'INVALID_PEPTIDE_CARR' if ml.nil?
      return ml, final_pep, come_back

    # bennett string looks like ABCKXYZ, always K as middle character
    # bennett string may have some number of 'x' at start or end
    elsif parse_method == 'bennett'
      ml = raw_pep.length / 2
      return -1, 'INVALID_PEPTIDE_BENNETT', come_back if raw_pep[ml] != 'K'
      final_pep = raw_pep

      # get rid of x's at beginning, if any
      while final_pep[0] == 'x' do
        final_pep = final_pep[1..-1]
        ml = ml - 1
      end
      # get rid of x's at end, if any
      final_pep.gsub!(/x/, '')

      return ml, final_pep, come_back

    # choudhary string looks like ABCK(1)YZ, or ABCK(1)WXK(1)YZ
    # or ABCK(0.947)WXK(1)YZ
    # we only want the K(1) sites
    # Note: this code assumes no more than two sites
    #
    elsif parse_method == 'choudhary'

      # get rid of non-certain percents, eg (0.947)
      clean_pep = raw_pep.gsub(/\(0.*\)/, '')

      if nth == 1
        # count (1)'s for reset flag, and find the first (1)
        if clean_pep.scan('(1)').count == 0
          return -1, 'INVALID_PEPTIDE_CHOUDHARY', come_back

        elsif clean_pep.scan('(1)').count == 2
          come_back = true
          ml = clean_pep.index('(1)') - 1
          return -1, 'INVALID_PEPTIDE_CHOUDHARY', come_back if raw_pep[ml] != 'K'
          clean_pep.gsub!(/\(1\)/, '')    # get rid of all (1)'s
          return ml, clean_pep, come_back

        else
          # just one (1)
          ml = clean_pep.index('(1)') - 1
          return -1, 'INVALID_PEPTIDE_CHOUDHARY', false if raw_pep[ml] != 'K'
          final_pep = clean_pep[0..ml].concat(clean_pep[ml+4..-1])  # get rid of only (1)
          return ml, final_pep, come_back
        end

      else    # nth == 2
        # we came back for second (1)
        come_back = false
        ml = clean_pep.index('(1)') - 1
        clean_pep = clean_pep[0..ml].concat(clean_pep[ml+4..-1])   # get rid of first (1)
        ml = clean_pep.index('(1)') - 1
        return -1, 'INVALID_PEPTIDE_CHOUDHARY', false if clean_pep[ml] != 'K'
        final_pep = clean_pep[0..ml].concat(clean_pep[ml+4..-1])   # get rid of second (1)
        return ml, final_pep, come_back

      end   # nth = 1 or 2

    else
      exit("** Unrecognized parse method #{parse_method} **")
    end

  end


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

    unaffiliated = []
    Peptide.all.each do |pep|

      if pep.proteins.count == 0
        if pep.datalines[0]
          in_index = pep.datalines[0].infile_id - 1
          in_name = infile_names[in_index]
          full_string = pep.datalines[0].tsv_string
          first_ipi_at = full_string.index('IPI')
          suffix = full_string[first_ipi_at..-1]
          ipi_string = suffix.split[0]
          triple = [in_name, ipi_string, pep.aseq]
        else
          triple = ['unk', 'unk', pep.aseq]
        end   # if dataline

        unaffiliated << triple
      end  # if

    end  # each

    unaffiliated    # return value

  end


end   # class Peptide
