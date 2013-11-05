class Protein < ActiveRecord::Base
  attr_accessible :aa_sequence, :accession, :description, :sp_or_tr

  has_many :datalines
  has_many :peptides, through: :datalines

  validates :sp_or_tr, :presence => true
  validates :accession, :presence => true
  validates :description, :presence => true
  validates :aa_sequence, :presence => true

  def self.parse_fasta_file(in_fast)   # class method
    @protein = Protein.new
    while !in_fast.eof?
      line = in_fast.readline.chomp.strip

      if line[0] == '>'
        # this is the name and info line for one protein
        @protein.save if @protein.valid?   # save the previous protein
        @protein = Protein.new
        info = line.split('|')
        @protein.sp_or_tr = info[0][1..2]     # discard '>' at start
        @protein.accession = info[1]
        @protein.description = info[2]
      else
        # these are some amino acids of the protein
        if @protein.aa_sequence.nil?
          @protein.aa_sequence = line
        else
          @protein.aa_sequence << line
        end

      end   # if line starts with >

    end   # while

    @protein.save if @protein.valid?   # save the final protein

  end     # parse_fasta_file

end
