# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#
# Read data file and create peptides, datalines
#

in_tiny = File.new('../TinyData/tiny.tsv')
puts 'Reading tiny.tsv'

line = in_tiny.readline.chomp     # discard first line

while !in_tiny.eof?
  line = in_tiny.readline.chomp
  sp = line.split("\t")
  if sp.length < 4
    next
  else
    raw_pep = sp[3]
  end

  # &&& see if this peptide is already in database

  @peptide = Peptide.new
  ml = raw_pep.index('k')   # first modified Lysine, some have none
  if ml.nil?
    next
  else
    @peptide.mod_loc = ml
    @peptide.aseq = raw_pep.upcase

    @dataline = @peptide.datalines.new        # add the dataline
    @dataline.tsv_string = line

    @peptide.save           # saves them both
  end
end   # while


#
# Read fasta file to create protein records
#

in_fast = File.new('../TinyData/tiny.fasta')
puts 'Reading tiny.fasta'

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


